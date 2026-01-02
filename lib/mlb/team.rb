require "equalizer"
require "shale"
require_relative "division"
require_relative "league"
require_relative "sport"
require_relative "venue"

# Ruby interface to the MLB Stats API
module MLB
  # Represents a team
  class Team < Shale::Mapper
    include Equalizer.new(:id)

    # All-Star status indicating player is on All-Star team
    ALL_STAR_YES = "Y".freeze
    # All-Star status indicating player is not on All-Star team
    ALL_STAR_NO = "N".freeze

    # Team ID for Arizona Diamondbacks
    AZ = 109
    # Team ID for Oakland Athletics
    ATH = 133
    # Team ID for Atlanta Braves
    ATL = 144
    # Team ID for Baltimore Orioles
    BAL = 110
    # Team ID for Boston Red Sox
    BOS = 111
    # Team ID for Chicago Cubs
    CHC = 112
    # Team ID for Chicago White Sox
    CWS = 145
    # Team ID for Cincinnati Reds
    CIN = 113
    # Team ID for Cleveland Guardians
    CLE = 114
    # Team ID for Colorado Rockies
    COL = 115
    # Team ID for Detroit Tigers
    DET = 116
    # Team ID for Houston Astros
    HOU = 117
    # Team ID for Kansas City Royals
    KC = 118
    # Team ID for Los Angeles Angels
    LAA = 108
    # Team ID for Los Angeles Dodgers
    LAD = 119
    # Team ID for Miami Marlins
    MIA = 146
    # Team ID for Milwaukee Brewers
    MIL = 158
    # Team ID for Minnesota Twins
    MIN = 142
    # Team ID for New York Mets
    NYM = 121
    # Team ID for New York Yankees
    NYY = 147
    # Team ID for Philadelphia Phillies
    PHI = 143
    # Team ID for Pittsburgh Pirates
    PIT = 134
    # Team ID for San Diego Padres
    SD = 135
    # Team ID for San Francisco Giants
    SF = 137
    # Team ID for Seattle Mariners
    SEA = 136
    # Team ID for St. Louis Cardinals
    STL = 138
    # Team ID for Tampa Bay Rays
    TB = 139
    # Team ID for Texas Rangers
    TEX = 140
    # Team ID for Toronto Blue Jays
    TOR = 141
    # Team ID for Washington Nationals
    WSH = 120

    attribute :id, Shale::Type::Integer
    attribute :spring_league, League
    attribute :all_star_status, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :season, Shale::Type::Integer
    attribute :venue, Venue
    attribute :spring_venue, Venue
    attribute :team_code, Shale::Type::String
    attribute :file_code, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :team_name, Shale::Type::String
    attribute :location_name, Shale::Type::String
    attribute :first_year_of_play, Shale::Type::Integer
    attribute :league, League
    attribute :division, Division
    attribute :sport, Sport
    attribute :short_name, Shale::Type::String
    attribute :franchise_name, Shale::Type::String
    attribute :club_name, Shale::Type::String
    attribute :active, Shale::Type::Boolean

    # Returns whether the team is active
    #
    # @api public
    # @example
    #   team.active?
    # @return [Boolean, nil] true if the team is active
    alias_method :active?, :active

    # Returns whether this is an All-Star team
    #
    # @api public
    # @example
    #   team.all_star? #=> false
    # @return [Boolean] whether this is an All-Star team
    def all_star? = all_star_status.eql?(ALL_STAR_YES)

    json do
      map "springLeague", to: :spring_league
      map "allStarStatus", to: :all_star_status
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "season", to: :season
      map "venue", to: :venue
      map "springVenue", to: :spring_venue
      map "teamCode", to: :team_code
      map "fileCode", to: :file_code
      map "abbreviation", to: :abbreviation
      map "teamName", to: :team_name
      map "locationName", to: :location_name
      map "firstYearOfPlay", to: :first_year_of_play
      map "league", to: :league
      map "division", to: :division
      map "sport", to: :sport
      map "shortName", to: :short_name
      map "franchiseName", to: :franchise_name
      map "clubName", to: :club_name
      map "active", to: :active
    end

    # Retrieves the team's roster
    #
    # @api public
    # @example
    #   team.roster
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<RosterEntry>] list of roster entries
    def roster(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("teams/#{id}/roster?#{Utils.build_query(season:)}")
      Roster.from_json(response).roster
    end
  end
end
