require "equalizer"
require "shale"
require_relative "season_date_info"
require_relative "sport"

module MLB
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

    alias_method :active?, :active
    alias_method :wild_card?, :has_wild_card
    alias_method :has_wildcard, :has_wild_card
    alias_method :wildcard?, :has_wild_card
    alias_method :split_season?, :has_split_season
    alias_method :playoff_points?, :has_playoff_points
    alias_method :conferences?, :conferences_in_use
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

    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
