require "equalizer"
require "shale"

module MLB
  # Represents a roster type
  class RosterType < Shale::Mapper
    include Equalizer.new(:parameter)

    # @!attribute [rw] description
    #   Returns the roster type description
    #   @api public
    #   @example
    #     roster_type.description #=> "40-Man Roster"
    #   @return [String] the roster type description
    attribute :description, Shale::Type::String

    # @!attribute [rw] lookup_name
    #   Returns the lookup name
    #   @api public
    #   @example
    #     roster_type.lookup_name #=> "40Man"
    #   @return [String] the lookup name
    attribute :lookup_name, Shale::Type::String

    # @!attribute [rw] parameter
    #   Returns the API parameter value
    #   @api public
    #   @example
    #     roster_type.parameter #=> "40Man"
    #   @return [String] the API parameter value
    attribute :parameter, Shale::Type::String

    json do
      map "description", to: :description
      map "lookupName", to: :lookup_name
      map "parameter", to: :parameter
    end
  end
end
