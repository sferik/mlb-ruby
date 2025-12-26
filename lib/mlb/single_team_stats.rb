require "shale"
require_relative "team_stats"

module MLB
  # Provides methods for fetching individual team stats from the API
  class SingleTeamStats < Shale::Mapper
    attribute :stats, TeamStatGroup, collection: true

    json do
      map "stats", to: :stats
    end

    # Retrieves stats for a specific team
    #
    # @api public
    # @example Get team hitting stats
    #   MLB::SingleTeamStats.find(team: 147, season: 2024, group: "hitting")
    # @example Get team pitching stats
    #   MLB::SingleTeamStats.find(team: Team.new(id: 147), season: 2024, group: "pitching")
    # @param team [Integer, Team] the team ID or Team object
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param group [String] the stat group (hitting, pitching, fielding)
    # @param stats [String] the stats type (default: season)
    # @return [Array<TeamStat>] the team stats
    def self.find(team:, season: nil, group: "hitting", stats: "season")
      season ||= Utils.current_season
      team_id = Utils.extract_id(team)
      params = {season:, group:, stats:}
      response = CLIENT.get("teams/#{team_id}/stats?#{Utils.build_query(params)}")
      from_json(response).stats.first&.splits || []
    end
  end
end
