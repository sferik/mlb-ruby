require "equalizer"
require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a team leader entry
  class TeamLeader < Shale::Mapper
    include Equalizer.new(:rank, :person)

    # @!attribute [rw] rank
    #   Returns the leader's rank
    #   @api public
    #   @example
    #     leader.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] value
    #   Returns the stat value
    #   @api public
    #   @example
    #     leader.value #=> "58"
    #   @return [String] the stat value
    attribute :value, Shale::Type::String

    # @!attribute [rw] person
    #   Returns the player
    #   @api public
    #   @example
    #     leader.person #=> #<MLB::Player>
    #   @return [Player] the player
    attribute :person, Player

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     leader.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     leader.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    json do
      map "rank", to: :rank
      map "value", to: :value
      map "person", to: :person
      map "team", to: :team
      map "season", to: :season
    end
  end
end
