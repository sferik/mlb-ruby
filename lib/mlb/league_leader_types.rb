require_relative "collection"
require_relative "league_leader_type"

module MLB
  # Provides methods for fetching league leader types from the API
  #
  # @example Fetch all league leader types
  #   MLB::LeagueLeaderTypes.all #=> [#<MLB::LeagueLeaderType>, ...]
  class LeagueLeaderTypes < Collection
    collection endpoint: "leagueLeaderTypes", item_type: LeagueLeaderType, collection_name: :league_leader_types
  end
end
