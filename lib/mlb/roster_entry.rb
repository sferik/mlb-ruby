require "equalizer"
require "shale"
require_relative "player"
require_relative "position"
require_relative "status"

module MLB
  class RosterEntry < Shale::Mapper
    include Equalizer.new(:team_id, :player)

    attribute :player, Player
    attribute :jersey_number, Shale::Type::Integer
    attribute :position, Position
    attribute :status, Status
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
