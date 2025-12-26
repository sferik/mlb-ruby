require "shale"
require_relative "team"

module MLB
  # Collection of teams from the MLB Stats API
  class Teams < Shale::Mapper
    attribute :teams, Team, collection: true

    # Retrieves all teams
    #
    # @api public
    # @example
    #   MLB::Teams.all
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Team>] list of all teams
    def self.all(season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {sportId: Utils.extract_id(sport), season:}
      response = CLIENT.get("teams?#{Utils.build_query(params)}")
      from_json(response).teams
    end

    # Finds a team by ID
    #
    # @api public
    # @example
    #   MLB::Teams.find(147)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Team, nil] the team if found
    def self.find(team, season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {sportId: Utils.extract_id(sport), season:}
      response = CLIENT.get("teams/#{Utils.extract_id(team)}?#{Utils.build_query(params)}")
      from_json(response).teams.first
    end
  end
end
