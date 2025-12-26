require "shale"
require_relative "free_agent"

module MLB
  # Provides methods for fetching free agent data from the API
  class FreeAgents < Shale::Mapper
    # @!attribute [rw] free_agents
    #   Returns the free agents
    #   @api public
    #   @example
    #     free_agents.free_agents #=> [#<MLB::FreeAgent>, ...]
    #   @return [Array<FreeAgent>] the free agents
    attribute :free_agents, FreeAgent, collection: true

    json do
      map "freeAgents", to: :free_agents
    end

    # Retrieves all free agents for a season
    #
    # @api public
    # @example Get free agents for the current season
    #   MLB::FreeAgents.all
    # @example Get free agents for a specific season
    #   MLB::FreeAgents.all(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<FreeAgent>] the free agents
    def self.all(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("people/freeAgents?#{Utils.build_query(season:)}")
      from_json(response).free_agents
    end
  end
end
