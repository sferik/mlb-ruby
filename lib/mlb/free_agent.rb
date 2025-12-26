require "equalizer"
require "shale"
require_relative "player"
require_relative "team"
require_relative "position"

module MLB
  # Represents a free agent
  class FreeAgent < Shale::Mapper
    include Equalizer.new(:player)

    # @!attribute [rw] player
    #   Returns the player
    #   @api public
    #   @example
    #     free_agent.player #=> #<MLB::Player>
    #   @return [Player] the player
    attribute :player, Player

    # @!attribute [rw] original_team
    #   Returns the team the player left
    #   @api public
    #   @example
    #     free_agent.original_team #=> #<MLB::Team>
    #   @return [Team] the original team
    attribute :original_team, Team

    # @!attribute [rw] new_team
    #   Returns the team the player signed with
    #   @api public
    #   @example
    #     free_agent.new_team #=> #<MLB::Team>
    #   @return [Team] the new team
    attribute :new_team, Team

    # @!attribute [rw] notes
    #   Returns signing notes
    #   @api public
    #   @example
    #     free_agent.notes #=> "Seven-Year Contract"
    #   @return [String] the notes
    attribute :notes, Shale::Type::String

    # @!attribute [rw] date_signed
    #   Returns the date the player signed
    #   @api public
    #   @example
    #     free_agent.date_signed #=> #<Date: 2024-12-10>
    #   @return [Date] the date signed
    attribute :date_signed, Shale::Type::Date

    # @!attribute [rw] date_declared
    #   Returns the date the player declared free agency
    #   @api public
    #   @example
    #     free_agent.date_declared #=> #<Date: 2024-10-31>
    #   @return [Date] the date declared
    attribute :date_declared, Shale::Type::Date

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     free_agent.position #=> #<MLB::Position>
    #   @return [Position] the position
    attribute :position, Position

    json do
      map "player", to: :player
      map "originalTeam", to: :original_team
      map "newTeam", to: :new_team
      map "notes", to: :notes
      map "dateSigned", to: :date_signed
      map "dateDeclared", to: :date_declared
      map "position", to: :position
    end
  end
end
