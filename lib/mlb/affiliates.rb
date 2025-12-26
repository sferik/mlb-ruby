require "shale"
require_relative "team"

module MLB
  # Provides methods for fetching team affiliates from the API
  class Affiliates < Shale::Mapper
    attribute :teams, Team, collection: true

    json do
      map "teams", to: :teams
    end

    # Retrieves affiliates for a team
    #
    # @api public
    # @example Get affiliates for a team
    #   MLB::Affiliates.find(team: 147, season: 2024)
    # @param team [Team, Integer] the team or team ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Team>] the affiliated teams
    def self.find(team:, season: nil)
      season ||= Utils.current_season
      params = {teamIds: Utils.extract_id(team), season:}
      response = CLIENT.get("teams/affiliates?#{Utils.build_query(params)}")
      from_json(response).teams
    end
  end
end
