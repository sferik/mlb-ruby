require_relative "collection"
require_relative "standings_type"

module MLB
  # Provides methods for fetching standings types from the API
  #
  # @example Fetch all standings types
  #   MLB::StandingsTypes.all #=> [#<MLB::StandingsType>, ...]
  class StandingsTypes < Collection
    collection endpoint: "standingsTypes", item_type: StandingsType, collection_name: :standings_types
  end
end
