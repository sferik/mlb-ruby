require "shale"
require_relative "team_stat"

module MLB
  # Represents a stat type group
  class TeamStatGroup < Shale::Mapper
    # @!attribute [rw] splits
    #   Returns the stat splits
    #   @api public
    #   @example
    #     group.splits #=> [#<MLB::TeamStat>, ...]
    #   @return [Array<TeamStat>] the stat splits
    attribute :splits, TeamStat, collection: true

    json do
      map "splits", to: :splits
    end
  end

  # Provides methods for fetching team stats from the API
  class TeamStats < Shale::Mapper
    # @!attribute [rw] stats
    #   Returns the stat groups
    #   @api public
    #   @example
    #     team_stats.stats #=> [#<MLB::TeamStatGroup>, ...]
    #   @return [Array<TeamStatGroup>] the stat groups
    attribute :stats, TeamStatGroup, collection: true

    json do
      map "stats", to: :stats
    end

    # Retrieves team stats
    #
    # @api public
    # @example Get team hitting stats
    #   MLB::TeamStats.find(season: 2024, group: "hitting")
    # @example Get team pitching stats
    #   MLB::TeamStats.find(season: 2024, group: "pitching", stats: "season")
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param group [String] the stat group (hitting, pitching, fielding)
    # @param stats [String] the stats type (default: season)
    # @return [Array<TeamStat>] the team stats
    def self.find(season: nil, group: "hitting", stats: "season")
      season ||= Utils.current_season
      params = {season:, group:, stats:}
      response = CLIENT.get("teams/stats?#{Utils.build_query(params)}")
      from_json(response).stats.first&.splits || []
    end
  end
end
