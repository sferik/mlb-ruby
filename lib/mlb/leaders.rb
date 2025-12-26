require "shale"
require_relative "leader"

module MLB
  # Represents a leader category result
  class LeaderCategory < Shale::Mapper
    # @!attribute [rw] leader_category
    #   Returns the category name
    #   @api public
    #   @example
    #     category.leader_category #=> "homeRuns"
    #   @return [String] the category
    attribute :leader_category, Shale::Type::String

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     category.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] leaders
    #   Returns the leaders
    #   @api public
    #   @example
    #     category.leaders #=> [#<MLB::Leader>, ...]
    #   @return [Array<Leader>] the leaders
    attribute :leaders, Leader, collection: true

    json do
      map "leaderCategory", to: :leader_category
      map "season", to: :season
      map "leaders", to: :leaders
    end
  end

  # Provides methods for fetching league leaders from the API
  class Leaders < Shale::Mapper
    # @!attribute [rw] league_leaders
    #   Returns the league leaders
    #   @api public
    #   @example
    #     leaders.league_leaders #=> [#<MLB::LeaderCategory>, ...]
    #   @return [Array<LeaderCategory>] the league leaders
    attribute :league_leaders, LeaderCategory, collection: true

    json do
      map "leagueLeaders", to: :league_leaders
    end

    # Retrieves league leaders for a category
    #
    # @api public
    # @example Get home run leaders
    #   MLB::Leaders.find(category: "homeRuns", season: 2024)
    # @param category [String] the stat category
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param limit [Integer] the number of leaders to return (defaults to 10)
    # @return [Array<Leader>] the leaders
    def self.find(category:, season: nil, limit: 10)
      season ||= Utils.current_season
      params = {leaderCategories: category, season:, limit:}
      response = CLIENT.get("stats/leaders?#{Utils.build_query(params)}")
      from_json(response).league_leaders.first&.leaders || []
    end
  end
end
