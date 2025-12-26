require "equalizer"
require "shale"

module MLB
  # Represents a baseball position
  class Position < Shale::Mapper
    include Equalizer.new(:code)

    TYPE_PITCHER = "Pitcher".freeze
    TYPE_CATCHER = "Catcher".freeze
    TYPE_INFIELDER = "Infielder".freeze
    TYPE_OUTFIELDER = "Outfielder".freeze

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

    # Returns whether this is a pitcher position
    #
    # @api public
    # @example
    #   position.pitcher? #=> true
    # @return [Boolean] whether this is a pitcher
    def pitcher? = type.eql?(TYPE_PITCHER)

    # Returns whether this is a catcher position
    #
    # @api public
    # @example
    #   position.catcher? #=> false
    # @return [Boolean] whether this is a catcher
    def catcher? = type.eql?(TYPE_CATCHER)

    # Returns whether this is an infielder position
    #
    # @api public
    # @example
    #   position.infielder? #=> false
    # @return [Boolean] whether this is an infielder
    def infielder? = type.eql?(TYPE_INFIELDER)

    # Returns whether this is an outfielder position
    #
    # @api public
    # @example
    #   position.outfielder? #=> false
    # @return [Boolean] whether this is an outfielder
    def outfielder? = type.eql?(TYPE_OUTFIELDER)

    json do
      map "code", to: :code
      map "name", to: :name
      map "type", to: :type
      map "abbreviation", to: :abbreviation
    end
  end
end
