require "equalizer"
require "shale"

module MLB
  # Represents a baseball event type
  class EventType < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the event code
    #   @api public
    #   @example
    #     event_type.code #=> "single"
    #   @return [String] the event code
    attribute :code, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the event description
    #   @api public
    #   @example
    #     event_type.description #=> "Single"
    #   @return [String] the event description
    attribute :description, Shale::Type::String

    # @!attribute [rw] plate_appearance
    #   Returns whether this event counts as a plate appearance
    #   @api public
    #   @example
    #     event_type.plate_appearance #=> true
    #   @return [Boolean] whether this event counts as a plate appearance
    attribute :plate_appearance, Shale::Type::Boolean

    # @!attribute [rw] hit
    #   Returns whether this event is a hit
    #   @api public
    #   @example
    #     event_type.hit #=> true
    #   @return [Boolean] whether this event is a hit
    attribute :hit, Shale::Type::Boolean

    # @!attribute [rw] base_running_event
    #   Returns whether this event involves base running
    #   @api public
    #   @example
    #     event_type.base_running_event #=> false
    #   @return [Boolean] whether this event involves base running
    attribute :base_running_event, Shale::Type::Boolean

    alias_method :plate_appearance?, :plate_appearance
    alias_method :hit?, :hit
    alias_method :base_running_event?, :base_running_event

    json do
      map "code", to: :code
      map "description", to: :description
      map "plateAppearance", to: :plate_appearance
      map "hit", to: :hit
      map "baseRunningEvent", to: :base_running_event
    end
  end
end
