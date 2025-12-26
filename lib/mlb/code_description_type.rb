require "equalizer"
require "shale"

module MLB
  # Base class for simple code/description value objects from the MLB Stats API.
  # These represent enumerated types that consist of a code identifier and
  # human-readable description (e.g., pitch types, wind directions, sky conditions).
  #
  # @api private
  # @abstract Subclass and define specific domain semantics
  class CodeDescriptionType < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the type code identifier
    #   @api public
    #   @example
    #     instance.code #=> "SL"
    #   @return [String] the type code identifier
    attribute :code, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the human-readable description
    #   @api public
    #   @example
    #     instance.description #=> "Slider"
    #   @return [String] the human-readable description
    attribute :description, Shale::Type::String

    json do
      map "code", to: :code
      map "description", to: :description
    end

    # Returns a string representation of the object
    #
    # @api public
    # @example
    #   pitch_type.to_s #=> "SL (Slider)"
    # @return [String] string representation
    def to_s
      "#{code} (#{description})"
    end
  end
end
