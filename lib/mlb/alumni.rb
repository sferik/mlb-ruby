require "shale"
require_relative "player"

module MLB
  # Provides methods for fetching team alumni from the API
  class Alumni < Shale::Mapper
    attribute :people, Player, collection: true

    json do
      map "people", to: :people
    end

    # Retrieves alumni for a team
    #
    # @api public
    # @example Get alumni for a team in a season
    #   MLB::Alumni.find(team: 147, season: 2024)
    # @example Get alumni for a team object
    #   MLB::Alumni.find(team: Team.new(id: 147), season: 2024)
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Player>] the alumni players
    def self.find(team:, season: nil)
      season ||= Utils.current_season
      team_id = Utils.extract_id(team)
      response = CLIENT.get("teams/#{team_id}/alumni?#{Utils.build_query(season:)}")
      from_json(response).people
    end
  end
end
