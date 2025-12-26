require "equalizer"
require "shale"
require_relative "player"
require_relative "team"
require_relative "league"
require_relative "sport"

module MLB
  # Represents a league leader
  class Leader < Shale::Mapper
    include Equalizer.new(:rank, :person)

    # @!attribute [rw] rank
    #   Returns the leader rank
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
    #   @return [String] the value
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

    # @!attribute [rw] league
    #   Returns the league
    #   @api public
    #   @example
    #     leader.league #=> #<MLB::League>
    #   @return [League] the league
    attribute :league, League

    # @!attribute [rw] sport
    #   Returns the sport
    #   @api public
    #   @example
    #     leader.sport #=> #<MLB::Sport>
    #   @return [Sport] the sport
    attribute :sport, Sport

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
      map "league", to: :league
      map "sport", to: :sport
      map "season", to: :season
    end
  end
end
