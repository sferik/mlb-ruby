require "equalizer"
require "shale"

module MLB
  # Represents a league leader statistic type
  class LeagueLeaderType < Shale::Mapper
    include Equalizer.new(:display_name)

    # @!attribute [rw] display_name
    #   Returns the display name for the leader type
    #   @api public
    #   @example
    #     league_leader_type.display_name #=> "homeRuns"
    #   @return [String] the display name for the leader type
    attribute :display_name, Shale::Type::String

    json do
      map "displayName", to: :display_name
    end
  end
end
