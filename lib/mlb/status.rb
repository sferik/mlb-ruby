require "equalizer"
require "shale"

module MLB
  # Represents a roster status
  class Status < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the status code
    #   @api public
    #   @example
    #     status.code #=> "A"
    #   @return [String] the status code
    attribute :code, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the status description
    #   @api public
    #   @example
    #     status.description #=> "Active"
    #   @return [String] the status description
    attribute :description, Shale::Type::String
  end
end
