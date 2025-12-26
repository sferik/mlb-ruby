require "shale"
require_relative "roster_entry"

module MLB
  # Provides methods for fetching team rosters from the API
  class Roster < Shale::Mapper
    attribute :roster, RosterEntry, collection: true

    # Finds a team's roster for a given season and sport
    #
    # @api public
    # @example
    #   MLB::Roster.find(team: 119) #=> [#<MLB::RosterEntry>, ...]
    # @param team [Team, Integer] the team or team ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Sport, Integer] the sport or sport ID
    # @return [Array<RosterEntry>] the list of roster entries
    def self.find(team:, season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      team_id = Utils.extract_id(team)
      params = {season:, sportId: Utils.extract_id(sport)}
      response = CLIENT.get("teams/#{team_id}/roster?#{Utils.build_query(params)}")
      from_json(response).roster
    end
  end
end
