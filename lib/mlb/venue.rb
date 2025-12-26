require "equalizer"
require "shale"

module MLB
  # Represents a venue (stadium/ballpark)
  class Venue < Shale::Mapper
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :active, Shale::Type::Boolean
    attribute :season, Shale::Type::Integer

    # Returns whether the venue is active
    #
    # @api public
    # @example
    #   venue.active?
    # @return [Boolean, nil] true if the venue is active
    alias_method :active?, :active
  end
end
