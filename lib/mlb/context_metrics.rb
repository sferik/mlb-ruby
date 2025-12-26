require "shale"

module MLB
  # Represents sacrifice fly probability for a specific field zone
  class SacFlyProbability < Shale::Mapper
    include Equalizer.new(:probability)

    # @!attribute [rw] probability
    #   Returns the probability of a sacrifice fly to this field zone
    #   @api public
    #   @example
    #     sac_fly.probability #=> 0.25
    #   @return [Float] probability value between 0 and 1
    attribute :probability, Shale::Type::Float

    json do
      map "probability", to: :probability
    end
  end

  # Provides real-time context metrics for a game including win probability
  # and sacrifice fly probabilities by field zone
  #
  # Context metrics are useful for understanding game state and
  # making predictions about likely outcomes.
  class ContextMetrics < Shale::Mapper
    # @!attribute [rw] home_win_probability
    #   Returns the home team's probability of winning
    #   @api public
    #   @example
    #     metrics.home_win_probability #=> 0.52
    #   @return [Float] probability value between 0 and 1
    attribute :home_win_probability, Shale::Type::Float

    # @!attribute [rw] away_win_probability
    #   Returns the away team's probability of winning
    #   @api public
    #   @example
    #     metrics.away_win_probability #=> 0.48
    #   @return [Float] probability value between 0 and 1
    attribute :away_win_probability, Shale::Type::Float

    # @!attribute [rw] left_field_sac_fly_probability
    #   Returns sacrifice fly probability for left field
    #   @api public
    #   @example
    #     metrics.left_field_sac_fly_probability.probability #=> 0.25
    #   @return [SacFlyProbability] left field sac fly metrics
    attribute :left_field_sac_fly_probability, SacFlyProbability

    # @!attribute [rw] center_field_sac_fly_probability
    #   Returns sacrifice fly probability for center field
    #   @api public
    #   @example
    #     metrics.center_field_sac_fly_probability.probability #=> 0.30
    #   @return [SacFlyProbability] center field sac fly metrics
    attribute :center_field_sac_fly_probability, SacFlyProbability

    # @!attribute [rw] right_field_sac_fly_probability
    #   Returns sacrifice fly probability for right field
    #   @api public
    #   @example
    #     metrics.right_field_sac_fly_probability.probability #=> 0.35
    #   @return [SacFlyProbability] right field sac fly metrics
    attribute :right_field_sac_fly_probability, SacFlyProbability

    json do
      map "homeWinProbability", to: :home_win_probability
      map "awayWinProbability", to: :away_win_probability
      map "leftFieldSacFlyProbability", to: :left_field_sac_fly_probability
      map "centerFieldSacFlyProbability", to: :center_field_sac_fly_probability
      map "rightFieldSacFlyProbability", to: :right_field_sac_fly_probability
    end

    # Retrieves context metrics for a specific game
    #
    # @api public
    # @example Using a game primary key
    #   MLB::ContextMetrics.find(game: 745571)
    # @example Using a ScheduledGame object
    #   MLB::ContextMetrics.find(game: scheduled_game)
    # @param game [Integer, #game_pk] game ID or object responding to #game_pk
    # @return [ContextMetrics] the context metrics for the game
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/contextMetrics")
      from_json(response)
    end
  end
end
