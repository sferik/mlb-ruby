require "equalizer"
require "shale"

module MLB
  # Represents a baseball position
  class Position < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the position code
    #   @api public
    #   @example
    #     position.code #=> "1"
    #   @return [String] the position code
    attribute :code, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the position name
    #   @api public
    #   @example
    #     position.name #=> "Pitcher"
    #   @return [String] the position name
    attribute :name, Shale::Type::String

    # @!attribute [rw] type
    #   Returns the position type
    #   @api public
    #   @example
    #     position.type #=> "Pitcher"
    #   @return [String] the position type
    attribute :type, Shale::Type::String

    # @!attribute [rw] abbreviation
    #   Returns the position abbreviation
    #   @api public
    #   @example
    #     position.abbreviation #=> "P"
    #   @return [String] the position abbreviation
    attribute :abbreviation, Shale::Type::String

    json do
      map "code", to: :code
      map "name", to: :name
      map "type", to: :type
      map "abbreviation", to: :abbreviation
    end
  end
end
