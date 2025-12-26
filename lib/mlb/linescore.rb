require "shale"
require_relative "inning_score"
require_relative "linescore_teams"

module MLB
  # Represents a game's linescore
  class Linescore < Shale::Mapper
    INNING_TOP = "Top".freeze
    INNING_MIDDLE = "Middle".freeze
    INNING_BOTTOM = "Bottom".freeze

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

    # Returns whether the inning state is top
    #
    # @api public
    # @example
    #   linescore.top? #=> true
    # @return [Boolean] whether it's the top of the inning
    def top? = inning_state.eql?(INNING_TOP)

    # Returns whether the inning state is middle
    #
    # @api public
    # @example
    #   linescore.middle? #=> false
    # @return [Boolean] whether it's the middle of the inning
    def middle? = inning_state.eql?(INNING_MIDDLE)

    # Returns whether the inning state is bottom
    #
    # @api public
    # @example
    #   linescore.bottom? #=> false
    # @return [Boolean] whether it's the bottom of the inning
    def bottom? = inning_state.eql?(INNING_BOTTOM)

    # Returns whether it's the 1st inning
    #
    # @api public
    # @example
    #   linescore.first? #=> true
    # @return [Boolean] whether it's the 1st inning
    def first? = current_inning.eql?(1)

    # Returns whether it's the 2nd inning
    #
    # @api public
    # @example
    #   linescore.second? #=> false
    # @return [Boolean] whether it's the 2nd inning
    def second? = current_inning.eql?(2)

    # Returns whether it's the 3rd inning
    #
    # @api public
    # @example
    #   linescore.third? #=> false
    # @return [Boolean] whether it's the 3rd inning
    def third? = current_inning.eql?(3)

    # Returns whether it's the 4th inning
    #
    # @api public
    # @example
    #   linescore.fourth? #=> false
    # @return [Boolean] whether it's the 4th inning
    def fourth? = current_inning.eql?(4)

    # Returns whether it's the 5th inning
    #
    # @api public
    # @example
    #   linescore.fifth? #=> false
    # @return [Boolean] whether it's the 5th inning
    def fifth? = current_inning.eql?(5)

    # Returns whether it's the 6th inning
    #
    # @api public
    # @example
    #   linescore.sixth? #=> false
    # @return [Boolean] whether it's the 6th inning
    def sixth? = current_inning.eql?(6)

    # Returns whether it's the 7th inning
    #
    # @api public
    # @example
    #   linescore.seventh? #=> false
    # @return [Boolean] whether it's the 7th inning
    def seventh? = current_inning.eql?(7)

    # Returns whether it's the 8th inning
    #
    # @api public
    # @example
    #   linescore.eighth? #=> false
    # @return [Boolean] whether it's the 8th inning
    def eighth? = current_inning.eql?(8)

    # Returns whether it's the 9th inning
    #
    # @api public
    # @example
    #   linescore.ninth? #=> false
    # @return [Boolean] whether it's the 9th inning
    def ninth? = current_inning.eql?(9)

    # Returns whether it's the 10th inning
    #
    # @api public
    # @example
    #   linescore.tenth? #=> false
    # @return [Boolean] whether it's the 10th inning
    def tenth? = current_inning.eql?(10)

    # Returns whether it's the 11th inning
    #
    # @api public
    # @example
    #   linescore.eleventh? #=> false
    # @return [Boolean] whether it's the 11th inning
    def eleventh? = current_inning.eql?(11)

    # Returns whether it's the 12th inning
    #
    # @api public
    # @example
    #   linescore.twelfth? #=> false
    # @return [Boolean] whether it's the 12th inning
    def twelfth? = current_inning.eql?(12)

    # Returns whether it's the 13th inning
    #
    # @api public
    # @example
    #   linescore.thirteenth? #=> false
    # @return [Boolean] whether it's the 13th inning
    def thirteenth? = current_inning.eql?(13)

    # Returns whether it's the 14th inning
    #
    # @api public
    # @example
    #   linescore.fourteenth? #=> false
    # @return [Boolean] whether it's the 14th inning
    def fourteenth? = current_inning.eql?(14)

    # Returns whether it's the 15th inning
    #
    # @api public
    # @example
    #   linescore.fifteenth? #=> false
    # @return [Boolean] whether it's the 15th inning
    def fifteenth? = current_inning.eql?(15)

    # Returns whether it's the 16th inning
    #
    # @api public
    # @example
    #   linescore.sixteenth? #=> false
    # @return [Boolean] whether it's the 16th inning
    def sixteenth? = current_inning.eql?(16)

    # Returns whether it's the 17th inning
    #
    # @api public
    # @example
    #   linescore.seventeenth? #=> false
    # @return [Boolean] whether it's the 17th inning
    def seventeenth? = current_inning.eql?(17)

    # Returns whether it's the 18th inning
    #
    # @api public
    # @example
    #   linescore.eighteenth? #=> false
    # @return [Boolean] whether it's the 18th inning
    def eighteenth? = current_inning.eql?(18)

    # Returns whether it's the 19th inning
    #
    # @api public
    # @example
    #   linescore.nineteenth? #=> false
    # @return [Boolean] whether it's the 19th inning
    def nineteenth? = current_inning.eql?(19)

    # Returns whether it's the 20th inning
    #
    # @api public
    # @example
    #   linescore.twentieth? #=> false
    # @return [Boolean] whether it's the 20th inning
    def twentieth? = current_inning.eql?(20)

    # Returns whether it's the 21st inning
    #
    # @api public
    # @example
    #   linescore.twenty_first? #=> false
    # @return [Boolean] whether it's the 21st inning
    def twenty_first? = current_inning.eql?(21)

    # Returns whether it's the 22nd inning
    #
    # @api public
    # @example
    #   linescore.twenty_second? #=> false
    # @return [Boolean] whether it's the 22nd inning
    def twenty_second? = current_inning.eql?(22)

    # Returns whether it's the 23rd inning
    #
    # @api public
    # @example
    #   linescore.twenty_third? #=> false
    # @return [Boolean] whether it's the 23rd inning
    def twenty_third? = current_inning.eql?(23)

    # Returns whether it's the 24th inning
    #
    # @api public
    # @example
    #   linescore.twenty_fourth? #=> false
    # @return [Boolean] whether it's the 24th inning
    def twenty_fourth? = current_inning.eql?(24)

    # Returns whether it's the 25th inning
    #
    # @api public
    # @example
    #   linescore.twenty_fifth? #=> false
    # @return [Boolean] whether it's the 25th inning
    def twenty_fifth? = current_inning.eql?(25)

    # Returns whether it's the 26th inning
    #
    # @api public
    # @example
    #   linescore.twenty_sixth? #=> false
    # @return [Boolean] whether it's the 26th inning
    def twenty_sixth? = current_inning.eql?(26)

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
