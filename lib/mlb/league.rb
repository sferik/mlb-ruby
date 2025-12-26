require "equalizer"
require "shale"
require_relative "comparable_by_attribute"
require_relative "season_date_info"
require_relative "sport"

module MLB
  # Represents a league (e.g., American League, National League)
  class League < Shale::Mapper
    include Comparable
    include ComparableByAttribute
    include Equalizer.new(:id)

    SEASON_PRESEASON = "preseason".freeze
    SEASON_INSEASON = "inseason".freeze
    SEASON_POSTSEASON = "postseason".freeze
    SEASON_OFFSEASON = "offseason".freeze

    # Returns the attribute used for sorting
    #
    # @api private
    # @return [Symbol] the attribute used for comparison
    def comparable_attribute = :sort_order

    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :name_short, Shale::Type::String
    attribute :season_state, Shale::Type::String
    attribute :has_wildcard, Shale::Type::Boolean
    attribute :has_split_season, Shale::Type::Boolean
    attribute :num_games, Shale::Type::Integer
    attribute :has_playoff_points, Shale::Type::Boolean
    attribute :num_teams, Shale::Type::Integer
    attribute :num_wildcard_teams, Shale::Type::Integer
    attribute :season_date_info, SeasonDateInfo
    attribute :season, Shale::Type::Integer
    attribute :org_code, Shale::Type::String
    attribute :conferences_in_use, Shale::Type::Boolean
    attribute :divisions_in_use, Shale::Type::Boolean
    attribute :sport, Sport
    attribute :sort_order, Shale::Type::Integer
    attribute :active, Shale::Type::Boolean

    # Checks if the league is active
    #
    # @api public
    # @example
    #   league.active? #=> true
    # @return [Boolean] whether the league is active
    def active? = active

    # Checks if the league has a wildcard
    #
    # @api public
    # @example
    #   league.wildcard? #=> true
    # @return [Boolean] whether the league has a wildcard
    def wildcard? = has_wildcard

    # Checks if the league has a split season
    #
    # @api public
    # @example
    #   league.split_season? #=> false
    # @return [Boolean] whether the league has a split season
    def split_season? = has_split_season

    # Checks if the league uses playoff points
    #
    # @api public
    # @example
    #   league.playoff_points? #=> false
    # @return [Boolean] whether the league uses playoff points
    def playoff_points? = has_playoff_points

    # Checks if the league uses conferences
    #
    # @api public
    # @example
    #   league.conferences? #=> false
    # @return [Boolean] whether the league uses conferences
    def conferences? = conferences_in_use

    # Checks if the league uses divisions
    #
    # @api public
    # @example
    #   league.divisions? #=> true
    # @return [Boolean] whether the league uses divisions
    def divisions? = divisions_in_use

    # Checks if the league is in preseason
    #
    # @api public
    # @example
    #   league.preseason? #=> false
    # @return [Boolean] whether the league is in preseason
    def preseason? = season_state.eql?(SEASON_PRESEASON)

    # Checks if the league is in season
    #
    # @api public
    # @example
    #   league.in_season? #=> true
    # @return [Boolean] whether the league is in season
    def in_season? = season_state.eql?(SEASON_INSEASON)

    # Checks if the league is in postseason
    #
    # @api public
    # @example
    #   league.postseason? #=> false
    # @return [Boolean] whether the league is in postseason
    def postseason? = season_state.eql?(SEASON_POSTSEASON)

    # Checks if the league is in offseason
    #
    # @api public
    # @example
    #   league.offseason? #=> false
    # @return [Boolean] whether the league is in offseason
    def offseason? = season_state.eql?(SEASON_OFFSEASON)

    json do
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "abbreviation", to: :abbreviation
      map "nameShort", to: :name_short
      map "seasonState", to: :season_state
      map "hasWildCard", to: :has_wildcard
      map "hasSplitSeason", to: :has_split_season
      map "numGames", to: :num_games
      map "hasPlayoffPoints", to: :has_playoff_points
      map "numTeams", to: :num_teams
      map "numWildcardTeams", to: :num_wildcard_teams
      map "seasonDateInfo", to: :season_date_info
      map "season", to: :season
      map "orgCode", to: :org_code
      map "conferencesInUse", to: :conferences_in_use
      map "divisionsInUse", to: :divisions_in_use
      map "sport", to: :sport
      map "sortOrder", to: :sort_order
      map "active", to: :active
    end
  end
end
