require_relative "collection"
require_relative "stat_type"

module MLB
  # Provides methods for fetching stat types from the API
  #
  # @example Fetch all stat types
  #   MLB::StatTypes.all #=> [#<MLB::StatType>, ...]
  class StatTypes < Collection
    collection endpoint: "statTypes", item_type: StatType, collection_name: :stat_types
  end
end
