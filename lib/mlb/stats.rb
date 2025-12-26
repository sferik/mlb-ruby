require "shale"
require_relative "player_stat"

module MLB
  # Represents a player stat group
  class PlayerStatGroup < Shale::Mapper
    attribute :splits, PlayerStat, collection: true

    json do
      map "splits", to: :splits
    end
  end

  # Provides methods for fetching player stats from the API
  class Stats < Shale::Mapper
    attribute :stats, PlayerStatGroup, collection: true

    json do
      map "stats", to: :stats
    end

    # Retrieves player stats
    #
    # @api public
    # @example Get player hitting stats
    #   MLB::Stats.find(season: 2024, group: "hitting")
    # @example Get player pitching stats
    #   MLB::Stats.find(season: 2024, group: "pitching", stats: "season")
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param group [String] the stat group (hitting, pitching, fielding)
    # @param stats [String] the stats type (default: season)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<PlayerStat>] the player stats
    def self.find(season: nil, group: "hitting", stats: "season", sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {season:, group:, stats:, sportIds: Utils.extract_id(sport)}
      response = CLIENT.get("stats?#{Utils.build_query(params)}")
      from_json(response).stats.first&.splits || []
    end
  end
end
