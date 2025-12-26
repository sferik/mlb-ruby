require "equalizer"
require "shale"

module MLB
  # Represents a stat type
  class StatType < Shale::Mapper
    include Equalizer.new(:display_name)

    # @!attribute [rw] display_name
    #   Returns the display name for the stat type
    #   @api public
    #   @example
    #     stat_type.display_name #=> "season"
    #   @return [String] the display name for the stat type
    attribute :display_name, Shale::Type::String

    json do
      map "displayName", to: :display_name
    end
  end
end
