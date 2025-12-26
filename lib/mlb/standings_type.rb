require "equalizer"
require "shale"

module MLB
  # Represents a standings type
  class StandingsType < Shale::Mapper
    include Equalizer.new(:name)

    # @!attribute [rw] name
    #   Returns the standings type name
    #   @api public
    #   @example
    #     standings_type.name #=> "regularSeason"
    #   @return [String] the standings type name
    attribute :name, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the description
    #   @api public
    #   @example
    #     standings_type.description #=> "Regular Season Standings"
    #   @return [String] the description
    attribute :description, Shale::Type::String
  end
end
