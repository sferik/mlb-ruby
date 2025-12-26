require_relative "collection"
require_relative "event_type"

module MLB
  # Provides methods for fetching event types from the API
  #
  # @example Fetch all event types
  #   MLB::EventTypes.all #=> [#<MLB::EventType>, ...]
  class EventTypes < Collection
    collection endpoint: "eventTypes", item_type: EventType, collection_name: :event_types
  end
end
