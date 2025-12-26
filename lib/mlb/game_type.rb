require_relative "id_description_type"

module MLB
  # Represents a game type (e.g., Regular Season, Postseason, Spring Training)
  class GameType < IdDescriptionType
    # Game type: Regular Season
    TYPE_REGULAR = "R".freeze
    # Game type: Spring Training
    TYPE_SPRING = "S".freeze
    # Game type: Exhibition
    TYPE_EXHIBITION = "E".freeze
    # Game type: All-Star Game
    TYPE_ALL_STAR = "A".freeze
    # Game type: Wild Card
    TYPE_WILD_CARD = "F".freeze
    # Game type: Division Series
    TYPE_DIVISION = "D".freeze
    # Game type: League Championship Series
    TYPE_LCS = "L".freeze
    # Game type: World Series
    TYPE_WORLD_SERIES = "W".freeze
    # Game type codes that indicate postseason games
    POSTSEASON_TYPES = %w[F D L W].freeze

    # Returns whether this is a regular season game type
    #
    # @api public
    # @example
    #   game_type.regular_season? #=> true
    # @return [Boolean] whether this is a regular season game type
    def regular_season? = id.eql?(TYPE_REGULAR)

    # Returns whether this is a spring training game type
    #
    # @api public
    # @example
    #   game_type.spring_training? #=> false
    # @return [Boolean] whether this is a spring training game type
    def spring_training? = id.eql?(TYPE_SPRING)

    # Returns whether this is an exhibition game type
    #
    # @api public
    # @example
    #   game_type.exhibition? #=> false
    # @return [Boolean] whether this is an exhibition game type
    def exhibition? = id.eql?(TYPE_EXHIBITION)

    # Returns whether this is an All-Star game type
    #
    # @api public
    # @example
    #   game_type.all_star? #=> false
    # @return [Boolean] whether this is an All-Star game type
    def all_star? = id.eql?(TYPE_ALL_STAR)

    # Returns whether this is a Wild Card game type
    #
    # @api public
    # @example
    #   game_type.wild_card? #=> false
    # @return [Boolean] whether this is a Wild Card game type
    def wild_card? = id.eql?(TYPE_WILD_CARD)

    # Returns whether this is a Division Series game type
    #
    # @api public
    # @example
    #   game_type.division_series? #=> false
    # @return [Boolean] whether this is a Division Series game type
    def division_series? = id.eql?(TYPE_DIVISION)

    # Returns whether this is a League Championship Series game type
    #
    # @api public
    # @example
    #   game_type.lcs? #=> false
    # @return [Boolean] whether this is a League Championship Series game type
    def lcs? = id.eql?(TYPE_LCS)

    # Returns whether this is a World Series game type
    #
    # @api public
    # @example
    #   game_type.world_series? #=> false
    # @return [Boolean] whether this is a World Series game type
    def world_series? = id.eql?(TYPE_WORLD_SERIES)

    # Returns whether this is a postseason game type
    #
    # @api public
    # @example
    #   game_type.postseason? #=> false
    # @return [Boolean] whether this is a postseason game type
    # mutant:disable - .to_s is for type safety; include?(nil) returns false anyway
    def postseason? = POSTSEASON_TYPES.include?(id.to_s)
  end
end
