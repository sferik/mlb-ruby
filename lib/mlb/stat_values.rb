require "shale"

module MLB
  # Represents offensive stat values for players or teams
  #
  # @example Access player stats
  #   player_stat.stat.games_played #=> 162
  #   player_stat.stat.home_runs #=> 54
  #
  # @example Access team stats
  #   team_stat.stat.runs #=> 829
  #   team_stat.stat.ops #=> ".781"
  class StatValues < Shale::Mapper
    # @!attribute [rw] games_played
    #   Returns the number of games played
    #   @api public
    #   @example
    #     stat.games_played #=> 162
    #   @return [Integer] games played
    attribute :games_played, Shale::Type::Integer

    # @!attribute [rw] runs
    #   Returns the number of runs scored
    #   @api public
    #   @example
    #     stat.runs #=> 122
    #   @return [Integer] runs scored
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] doubles
    #   Returns the number of doubles
    #   @api public
    #   @example
    #     stat.doubles #=> 28
    #   @return [Integer] doubles
    attribute :doubles, Shale::Type::Integer

    # @!attribute [rw] triples
    #   Returns the number of triples
    #   @api public
    #   @example
    #     stat.triples #=> 3
    #   @return [Integer] triples
    attribute :triples, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns the number of home runs
    #   @api public
    #   @example
    #     stat.home_runs #=> 54
    #   @return [Integer] home runs
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] strike_outs
    #   Returns the number of strikeouts
    #   @api public
    #   @example
    #     stat.strike_outs #=> 175
    #   @return [Integer] strikeouts
    attribute :strike_outs, Shale::Type::Integer

    # @!attribute [rw] base_on_balls
    #   Returns the number of walks
    #   @api public
    #   @example
    #     stat.base_on_balls #=> 111
    #   @return [Integer] walks
    attribute :base_on_balls, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns the number of hits
    #   @api public
    #   @example
    #     stat.hits #=> 177
    #   @return [Integer] hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] avg
    #   Returns the batting average
    #   @api public
    #   @example
    #     stat.avg #=> ".311"
    #   @return [String] batting average
    attribute :avg, Shale::Type::String

    # @!attribute [rw] at_bats
    #   Returns the number of at bats
    #   @api public
    #   @example
    #     stat.at_bats #=> 570
    #   @return [Integer] at bats
    attribute :at_bats, Shale::Type::Integer

    # @!attribute [rw] obp
    #   Returns the on-base percentage
    #   @api public
    #   @example
    #     stat.obp #=> ".425"
    #   @return [String] on-base percentage
    attribute :obp, Shale::Type::String

    # @!attribute [rw] slg
    #   Returns the slugging percentage
    #   @api public
    #   @example
    #     stat.slg #=> ".686"
    #   @return [String] slugging percentage
    attribute :slg, Shale::Type::String

    # @!attribute [rw] ops
    #   Returns the on-base plus slugging
    #   @api public
    #   @example
    #     stat.ops #=> "1.111"
    #   @return [String] on-base plus slugging
    attribute :ops, Shale::Type::String

    # @!attribute [rw] stolen_bases
    #   Returns the number of stolen bases
    #   @api public
    #   @example
    #     stat.stolen_bases #=> 9
    #   @return [Integer] stolen bases
    attribute :stolen_bases, Shale::Type::Integer

    # @!attribute [rw] rbi
    #   Returns the number of runs batted in
    #   @api public
    #   @example
    #     stat.rbi #=> 130
    #   @return [Integer] runs batted in
    attribute :rbi, Shale::Type::Integer

    json do
      map "gamesPlayed", to: :games_played
      map "runs", to: :runs
      map "doubles", to: :doubles
      map "triples", to: :triples
      map "homeRuns", to: :home_runs
      map "strikeOuts", to: :strike_outs
      map "baseOnBalls", to: :base_on_balls
      map "hits", to: :hits
      map "avg", to: :avg
      map "atBats", to: :at_bats
      map "obp", to: :obp
      map "slg", to: :slg
      map "ops", to: :ops
      map "stolenBases", to: :stolen_bases
      map "rbi", to: :rbi
    end
  end

  # @deprecated Use {StatValues} instead
  PlayerStatValues = StatValues

  # @deprecated Use {StatValues} instead
  TeamStatValues = StatValues
end
