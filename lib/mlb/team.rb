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

    ALL_STAR_YES = "Y".freeze
    ALL_STAR_NO = "N".freeze

    # Team ID constants
    AZ = 109
    ATH = 133
    ATL = 144
    BAL = 110
    BOS = 111
    CHC = 112
    CWS = 145
    CIN = 113
    CLE = 114
    COL = 115
    DET = 116
    HOU = 117
    KC = 118
    LAA = 108
    LAD = 119
    MIA = 146
    MIL = 158
    MIN = 142
    NYM = 121
    NYY = 147
    PHI = 143
    PIT = 134
    SD = 135
    SF = 137
    SEA = 136
    STL = 138
    TB = 139
    TEX = 140
    TOR = 141
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
