require_relative "collection"
require_relative "stat_group"

module MLB
  # Provides methods for fetching stat groups from the API
  #
  # @example Fetch all stat groups
  #   MLB::StatGroups.all #=> [#<MLB::StatGroup>, ...]
  class StatGroups < Collection
    collection endpoint: "statGroups", item_type: StatGroup, collection_name: :stat_groups
  end
end
