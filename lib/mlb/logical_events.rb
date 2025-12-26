require_relative "collection"
require_relative "logical_event"

module MLB
  # Provides methods for fetching logical events from the API
  #
  # @example Fetch all logical events
  #   MLB::LogicalEvents.all #=> [#<MLB::LogicalEvent>, ...]
  class LogicalEvents < Collection
    collection endpoint: "logicalEvents", item_type: LogicalEvent, collection_name: :logical_events
  end
end
