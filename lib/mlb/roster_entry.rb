require "equalizer"
require "shale"
require_relative "player"
require_relative "position"
require_relative "status"

module MLB
  # Represents a player's entry on a team roster
  class RosterEntry < Shale::Mapper
    include Equalizer.new(:team_id, :player)

    # @!attribute [rw] player
    #   Returns the player on the roster
    #   @api public
    #   @example
    #     entry.player #=> #<MLB::Player>
    #   @return [Player] the player on the roster
    attribute :player, Player

    # @!attribute [rw] jersey_number
    #   Returns the player's jersey number
    #   @api public
    #   @example
    #     entry.jersey_number #=> 17
    #   @return [Integer] the player's jersey number
    attribute :jersey_number, Shale::Type::Integer

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     entry.position #=> #<MLB::Position>
    #   @return [Position] the player's position
    attribute :position, Position

    # @!attribute [rw] status
    #   Returns the player's roster status
    #   @api public
    #   @example
    #     entry.status #=> #<MLB::Status>
    #   @return [Status] the player's roster status
    attribute :status, Status

    # @!attribute [rw] team_id
    #   Returns the parent team ID
    #   @api public
    #   @example
    #     entry.team_id #=> 119
    #   @return [Integer] the parent team ID
    attribute :team_id, Shale::Type::Integer

    json do
      map "person", to: :player
      map "jerseyNumber", to: :jersey_number
      map "position", to: :position
      map "status", to: :status
      map "parentTeamId", to: :team_id
    end
  end
end
