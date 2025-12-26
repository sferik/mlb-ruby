require "equalizer"
require "shale"

module MLB
  # Represents a schedule event type
  class ScheduleEventType < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the event type code
    #   @api public
    #   @example
    #     schedule_event_type.code #=> "P"
    #   @return [String] the event type code
    attribute :code, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the event type name
    #   @api public
    #   @example
    #     schedule_event_type.name #=> "Postseason Game"
    #   @return [String] the event type name
    attribute :name, Shale::Type::String
  end
end
