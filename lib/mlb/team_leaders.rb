require "shale"
require_relative "team_leader"

module MLB
  # Represents a team leader category
  class TeamLeaderCategory < Shale::Mapper
    attribute :leader_category, Shale::Type::String
    attribute :season, Shale::Type::String
    attribute :leaders, TeamLeader, collection: true

    json do
      map "leaderCategory", to: :leader_category
      map "season", to: :season
      map "leaders", to: :leaders
    end
  end

  # Provides methods for fetching team leaders from the API
  class TeamLeaders < Shale::Mapper
    attribute :team_leaders, TeamLeaderCategory, collection: true

    json do
      map "teamLeaders", to: :team_leaders
    end

    # Retrieves team leaders for a category
    #
    # @api public
    # @example Get team leaders for home runs
    #   MLB::TeamLeaders.find(team: 147, category: "homeRuns", season: 2024)
    # @example Get team leaders with a team object
    #   MLB::TeamLeaders.find(team: Team.new(id: 147), category: "homeRuns")
    # @param team [Integer, Team] the team ID or Team object
    # @param category [String] the leader category
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<TeamLeader>] the team leaders
    def self.find(team:, category:, season: nil)
      season ||= Utils.current_season
      team_id = Utils.extract_id(team)
      params = {leaderCategories: category, season:}
      response = CLIENT.get("teams/#{team_id}/leaders?#{Utils.build_query(params)}")
      from_json(response).team_leaders.first&.leaders || []
    end
  end
end
