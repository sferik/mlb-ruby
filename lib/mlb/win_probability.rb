require "shale"

module MLB
  # Represents a win probability data point for a play
  class WinProbabilityEntry < Shale::Mapper
    include Equalizer.new(:at_bat_index, :home_team_win_probability)

    # @!attribute [rw] at_bat_index
    #   Returns the at bat index
    #   @api public
    #   @example
    #     entry.at_bat_index #=> 0
    #   @return [Integer] the at bat index
    attribute :at_bat_index, Shale::Type::Integer

    # @!attribute [rw] home_team_win_probability
    #   Returns the home team win probability
    #   @api public
    #   @example
    #     entry.home_team_win_probability #=> 0.52
    #   @return [Float] the home team win probability
    attribute :home_team_win_probability, Shale::Type::Float

    # @!attribute [rw] away_team_win_probability
    #   Returns the away team win probability
    #   @api public
    #   @example
    #     entry.away_team_win_probability #=> 0.48
    #   @return [Float] the away team win probability
    attribute :away_team_win_probability, Shale::Type::Float

    json do
      map "atBatIndex", to: :at_bat_index
      map "homeTeamWinProbability", to: :home_team_win_probability
      map "awayTeamWinProbability", to: :away_team_win_probability
    end
  end

  # Provides methods for fetching win probability data for a game
  class WinProbability < Shale::Mapper
    # @!attribute [rw] entries
    #   Returns the win probability entries
    #   @api public
    #   @example
    #     wp.entries #=> [#<MLB::WinProbabilityEntry>, ...]
    #   @return [Array<WinProbabilityEntry>] the win probability data points
    attribute :entries, WinProbabilityEntry, collection: true

    # Retrieves win probability data for a game
    #
    # @api public
    # @example Get win probability for a game
    #   MLB::WinProbability.find(game: 745571)
    # @example Get win probability using a ScheduledGame object
    #   MLB::WinProbability.find(game: scheduled_game)
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [Array<WinProbabilityEntry>] the win probability data points
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/winProbability") || "[]"
      JSON.parse(response).map { |entry| WinProbabilityEntry.from_json(entry.to_json) }
    end
  end
end
