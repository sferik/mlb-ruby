require "shale"
require_relative "job"

module MLB
  # Provides methods for fetching team personnel from the API
  class Personnel < Shale::Mapper
    attribute :roster, Job, collection: true

    json do
      map "roster", to: :roster
    end

    # Retrieves personnel for a team
    #
    # @api public
    # @example Get personnel for a team
    #   MLB::Personnel.find(team: 147, season: 2024)
    # @param team [Team, Integer] the team or team ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Job>] the personnel
    def self.find(team:, season: nil)
      season ||= Utils.current_season
      team_id = Utils.extract_id(team)
      response = CLIENT.get("teams/#{team_id}/personnel?#{Utils.build_query(season:)}")
      from_json(response).roster
    end
  end
end
