require "equalizer"
require "shale"
require_relative "season_date_info"
require_relative "sport"

module MLB
  # Represents a league (e.g., American League, National League)
  class League < Shale::Mapper
    include Comparable
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :name_short, Shale::Type::String
    attribute :season_state, Shale::Type::String
    attribute :has_wild_card, Shale::Type::Boolean
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

    # Returns whether the league is active
    #
    # @api public
    # @example
    #   league.active?
    # @return [Boolean, nil] true if the league is active
    alias_method :active?, :active

    # Returns whether the league has a wild card
    #
    # @api public
    # @example
    #   league.wild_card?
    # @return [Boolean, nil] true if the league has a wild card
    alias_method :wild_card?, :has_wild_card

    # Returns whether the league has a wild card (alias)
    #
    # @api public
    # @example
    #   league.has_wildcard
    # @return [Boolean, nil] true if the league has a wild card
    alias_method :has_wildcard, :has_wild_card

    # Returns whether the league has a wild card (alias)
    #
    # @api public
    # @example
    #   league.wildcard?
    # @return [Boolean, nil] true if the league has a wild card
    alias_method :wildcard?, :has_wild_card

    # Returns whether the league has a split season
    #
    # @api public
    # @example
    #   league.split_season?
    # @return [Boolean, nil] true if the league has a split season
    alias_method :split_season?, :has_split_season

    # Returns whether the league has playoff points
    #
    # @api public
    # @example
    #   league.playoff_points?
    # @return [Boolean, nil] true if the league has playoff points
    alias_method :playoff_points?, :has_playoff_points

    # Returns whether conferences are in use
    #
    # @api public
    # @example
    #   league.conferences?
    # @return [Boolean, nil] true if conferences are in use
    alias_method :conferences?, :conferences_in_use

    # Returns whether divisions are in use
    #
    # @api public
    # @example
    #   league.divisions?
    # @return [Boolean, nil] true if divisions are in use
    alias_method :divisions?, :divisions_in_use

    json do
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "abbreviation", to: :abbreviation
      map "nameShort", to: :name_short
      map "seasonState", to: :season_state
      map "hasWildCard", to: :has_wild_card
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

    # Compares leagues by sort order
    #
    # @api public
    # @example
    #   league1 <=> league2
    # @param other [League] the league to compare with
    # @return [Integer, nil] -1, 0, or 1 for comparison
    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
