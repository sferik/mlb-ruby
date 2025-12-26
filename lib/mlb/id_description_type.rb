require "equalizer"
require "shale"

module MLB
  # Base class for simple id/description value objects from the MLB Stats API.
  # Similar to CodeDescriptionType but uses 'id' as the identifier field.
  #
  # @api private
  # @abstract Subclass and define specific domain semantics
  class IdDescriptionType < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the type identifier
    #   @api public
    #   @example
    #     instance.id #=> "R"
    #   @return [String] the type identifier
    attribute :id, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the human-readable description
    #   @api public
    #   @example
    #     instance.description #=> "Regular Season"
    #   @return [String] the human-readable description
    attribute :description, Shale::Type::String

    json do
      map "id", to: :id
      map "description", to: :description
    end

    # Returns a string representation of the object
    #
    # @api public
    # @example
    #   game_type.to_s #=> "R (Regular Season)"
    # @return [String] string representation
    def to_s
      "#{id} (#{description})"
    end
  end
end
