require "shale"
require_relative "team"

module MLB
  # Provides methods for fetching team history from the API
  class TeamHistory < Shale::Mapper
    attribute :teams, Team, collection: true

    json do
      map "teams", to: :teams
    end

    # Retrieves historical team records
    #
    # @api public
    # @example Get history for a team
    #   MLB::TeamHistory.find(team: 147)
    # @example Get history for a team object
    #   MLB::TeamHistory.find(team: Team.new(id: 147))
    # @param team [Integer, Team] the team ID or Team object
    # @return [Array<Team>] historical team records
    def self.find(team:)
      params = {teamIds: Utils.extract_id(team)}
      response = CLIENT.get("teams/history?#{Utils.build_query(params)}")
      from_json(response).teams
    end
  end
end
