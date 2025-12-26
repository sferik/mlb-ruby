require "equalizer"
require "shale"
require_relative "stat_values"
require_relative "team"

module MLB
  # Represents a team stat split
  class TeamStat < Shale::Mapper
    include Equalizer.new(:team, :rank)

    # @!attribute [rw] season
    #   Returns the season for this stat split
    #   @api public
    #   @example
    #     team_stat.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] stat
    #   Returns the stat values
    #   @api public
    #   @example
    #     team_stat.stat.runs #=> 829
    #   @return [StatValues] the stat values
    attribute :stat, StatValues

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     team_stat.team.name #=> "New York Yankees"
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] rank
    #   Returns the rank in the stat leaderboard
    #   @api public
    #   @example
    #     team_stat.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    json do
      map "season", to: :season
      map "stat", to: :stat
      map "team", to: :team
      map "rank", to: :rank
    end
  end
end
