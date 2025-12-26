require "shale"
require_relative "inning_score"
require_relative "linescore_teams"

module MLB
  # Represents a game's linescore
  class Linescore < Shale::Mapper
    # @!attribute [rw] current_inning
    #   Returns the current inning number
    #   @api public
    #   @example
    #     linescore.current_inning #=> 9
    #   @return [Integer] the current inning
    attribute :current_inning, Shale::Type::Integer

    # @!attribute [rw] current_inning_ordinal
    #   Returns the current inning ordinal
    #   @api public
    #   @example
    #     linescore.current_inning_ordinal #=> "9th"
    #   @return [String] the current inning ordinal
    attribute :current_inning_ordinal, Shale::Type::String

    # @!attribute [rw] inning_state
    #   Returns the inning state (Top/Middle/Bottom/End)
    #   @api public
    #   @example
    #     linescore.inning_state #=> "Bottom"
    #   @return [String] the inning state
    attribute :inning_state, Shale::Type::String

    # @!attribute [rw] inning_half
    #   Returns the inning half
    #   @api public
    #   @example
    #     linescore.inning_half #=> "Bottom"
    #   @return [String] the inning half
    attribute :inning_half, Shale::Type::String

    # @!attribute [rw] is_top_inning
    #   Returns whether it's the top of the inning
    #   @api public
    #   @example
    #     linescore.top_inning? #=> false
    #   @return [Boolean] whether it's the top of the inning
    attribute :is_top_inning, Shale::Type::Boolean

    # @!attribute [rw] scheduled_innings
    #   Returns the number of scheduled innings
    #   @api public
    #   @example
    #     linescore.scheduled_innings #=> 9
    #   @return [Integer] the scheduled innings
    attribute :scheduled_innings, Shale::Type::Integer

    # @!attribute [rw] innings
    #   Returns the inning-by-inning scores
    #   @api public
    #   @example
    #     linescore.innings #=> [#<MLB::InningScore>, ...]
    #   @return [Array<InningScore>] the innings
    attribute :innings, InningScore, collection: true

    # @!attribute [rw] teams
    #   Returns the team totals
    #   @api public
    #   @example
    #     linescore.teams #=> #<MLB::LinescoreTeams>
    #   @return [LinescoreTeams] the teams
    attribute :teams, LinescoreTeams

    # Returns whether it's the top of the inning
    #
    # @api public
    # @example
    #   linescore.top_inning? #=> false
    # @return [Boolean] whether it's the top of the inning
    def top_inning?
      is_top_inning
    end

    json do
      map "currentInning", to: :current_inning
      map "currentInningOrdinal", to: :current_inning_ordinal
      map "inningState", to: :inning_state
      map "inningHalf", to: :inning_half
      map "isTopInning", to: :is_top_inning
      map "scheduledInnings", to: :scheduled_innings
      map "innings", to: :innings
      map "teams", to: :teams
    end

    # Retrieves the linescore for a game
    #
    # @api public
    # @example Get linescore for a game
    #   MLB::Linescore.find(game: 745726)
    # @param game [ScheduledGame, Integer] the game or game PK
    # @return [Linescore] the linescore
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/linescore")
      from_json(response)
    end
  end
end
