require "equalizer"
require "shale"

module MLB
  # Represents a situation code for statistical filtering
  class SituationCode < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the situation code
    #   @api public
    #   @example
    #     situation_code.code #=> "h"
    #   @return [String] the situation code
    attribute :code, Shale::Type::String

    # @!attribute [rw] sort_order
    #   Returns the sort order
    #   @api public
    #   @example
    #     situation_code.sort_order #=> 1
    #   @return [Integer] the sort order
    attribute :sort_order, Shale::Type::Integer

    # @!attribute [rw] navigation_menu
    #   Returns the navigation menu category
    #   @api public
    #   @example
    #     situation_code.navigation_menu #=> "Game"
    #   @return [String] the navigation menu category
    attribute :navigation_menu, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the description
    #   @api public
    #   @example
    #     situation_code.description #=> "Home Games"
    #   @return [String] the description
    attribute :description, Shale::Type::String

    # @!attribute [rw] team
    #   Returns whether this applies to team statistics
    #   @api public
    #   @example
    #     situation_code.team #=> true
    #   @return [Boolean] whether this applies to team statistics
    attribute :team, Shale::Type::Boolean

    # @!attribute [rw] batting
    #   Returns whether this applies to batting statistics
    #   @api public
    #   @example
    #     situation_code.batting #=> true
    #   @return [Boolean] whether this applies to batting statistics
    attribute :batting, Shale::Type::Boolean

    # @!attribute [rw] fielding
    #   Returns whether this applies to fielding statistics
    #   @api public
    #   @example
    #     situation_code.fielding #=> true
    #   @return [Boolean] whether this applies to fielding statistics
    attribute :fielding, Shale::Type::Boolean

    # @!attribute [rw] pitching
    #   Returns whether this applies to pitching statistics
    #   @api public
    #   @example
    #     situation_code.pitching #=> true
    #   @return [Boolean] whether this applies to pitching statistics
    attribute :pitching, Shale::Type::Boolean

    # Returns whether this applies to team statistics
    #
    # @api public
    # @example
    #   situation_code.team? #=> true
    # @return [Boolean] whether this applies to team statistics
    def team? = team

    # Returns whether this applies to batting statistics
    #
    # @api public
    # @example
    #   situation_code.batting? #=> true
    # @return [Boolean] whether this applies to batting statistics
    def batting? = batting

    # Returns whether this applies to fielding statistics
    #
    # @api public
    # @example
    #   situation_code.fielding? #=> true
    # @return [Boolean] whether this applies to fielding statistics
    def fielding? = fielding

    # Returns whether this applies to pitching statistics
    #
    # @api public
    # @example
    #   situation_code.pitching? #=> true
    # @return [Boolean] whether this applies to pitching statistics
    def pitching? = pitching

    json do
      map "code", to: :code
      map "sortOrder", to: :sort_order
      map "navigationMenu", to: :navigation_menu
      map "description", to: :description
      map "team", to: :team
      map "batting", to: :batting
      map "fielding", to: :fielding
      map "pitching", to: :pitching
    end
  end
end
