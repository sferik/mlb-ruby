require "equalizer"
require "shale"

module MLB
  # Represents a logical event code
  class LogicalEvent < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the logical event code
    #   @api public
    #   @example
    #     logical_event.code #=> "countChange"
    #   @return [String] the logical event code
    attribute :code, Shale::Type::String
  end
end
