require_relative "collection"
require_relative "roster_type"

module MLB
  # Provides methods for fetching roster types from the API
  #
  # @example Fetch all roster types
  #   MLB::RosterTypes.all #=> [#<MLB::RosterType>, ...]
  class RosterTypes < Collection
    collection endpoint: "rosterTypes", item_type: RosterType, collection_name: :roster_types
  end
end
