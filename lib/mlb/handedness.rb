require "equalizer"
require "shale"

module MLB
  # Represents handedness (batting or throwing side)
  class Handedness < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the handedness code
    #   @api public
    #   @example
    #     handedness.code #=> "L"
    #   @return [String] the handedness code
    attribute :code, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the handedness description
    #   @api public
    #   @example
    #     handedness.description #=> "Left"
    #   @return [String] the handedness description
    attribute :description, Shale::Type::String

    json do
      map "code", to: :code
      map "description", to: :description
    end
  end
end
