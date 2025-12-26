require "equalizer"
require "shale"

module MLB
  # Represents a stat group
  class StatGroup < Shale::Mapper
    include Equalizer.new(:display_name)

    # @!attribute [rw] display_name
    #   Returns the display name for the stat group
    #   @api public
    #   @example
    #     stat_group.display_name #=> "hitting"
    #   @return [String] the display name for the stat group
    attribute :display_name, Shale::Type::String

    json do
      map "displayName", to: :display_name
    end
  end
end
