require_relative "collection"
require_relative "schedule_event_type"

module MLB
  # Provides methods for fetching schedule event types from the API
  #
  # @example Fetch all schedule event types
  #   MLB::ScheduleEventTypes.all #=> [#<MLB::ScheduleEventType>, ...]
  class ScheduleEventTypes < Collection
    collection endpoint: "scheduleEventTypes", item_type: ScheduleEventType, collection_name: :schedule_event_types
  end
end
