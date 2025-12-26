require "equalizer"
require "shale"
require_relative "stat_values"
require_relative "player"
require_relative "team"
require_relative "position"

module MLB
  # Represents a player stat split
  class PlayerStat < Shale::Mapper
    include Equalizer.new(:player, :rank)

    # @!attribute [rw] season
    #   Returns the season for this stat split
    #   @api public
    #   @example
    #     player_stat.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] stat
    #   Returns the stat values
    #   @api public
    #   @example
    #     player_stat.stat.home_runs #=> 54
    #   @return [StatValues] the stat values
    attribute :stat, StatValues

    # @!attribute [rw] player
    #   Returns the player
    #   @api public
    #   @example
    #     player_stat.player.name #=> "Aaron Judge"
    #   @return [Player] the player
    attribute :player, Player

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     player_stat.team.name #=> "New York Yankees"
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] rank
    #   Returns the rank in the stat leaderboard
    #   @api public
    #   @example
    #     player_stat.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] position
    #   Returns the player's position
    #   @api public
    #   @example
    #     player_stat.position.abbreviation #=> "RF"
    #   @return [Position] the position
    attribute :position, Position

    json do
      map "season", to: :season
      map "stat", to: :stat
      map "player", to: :player
      map "team", to: :team
      map "rank", to: :rank
      map "position", to: :position
    end
  end
end
