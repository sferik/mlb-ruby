require "shale"

module MLB
  # Represents batting statistics for a team in a boxscore
  class BoxscoreBattingStats < Shale::Mapper
    # @!attribute [rw] runs
    #   Returns the runs scored
    #   @api public
    #   @example
    #     stats.runs #=> 8
    #   @return [Integer] the runs
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns the hits
    #   @api public
    #   @example
    #     stats.hits #=> 9
    #   @return [Integer] the hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] doubles
    #   Returns the doubles
    #   @api public
    #   @example
    #     stats.doubles #=> 2
    #   @return [Integer] the doubles
    attribute :doubles, Shale::Type::Integer

    # @!attribute [rw] triples
    #   Returns the triples
    #   @api public
    #   @example
    #     stats.triples #=> 1
    #   @return [Integer] the triples
    attribute :triples, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns the home runs
    #   @api public
    #   @example
    #     stats.home_runs #=> 3
    #   @return [Integer] the home runs
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] strike_outs
    #   Returns the strikeouts
    #   @api public
    #   @example
    #     stats.strike_outs #=> 10
    #   @return [Integer] the strikeouts
    attribute :strike_outs, Shale::Type::Integer

    # @!attribute [rw] base_on_balls
    #   Returns the walks
    #   @api public
    #   @example
    #     stats.base_on_balls #=> 3
    #   @return [Integer] the walks
    attribute :base_on_balls, Shale::Type::Integer

    # @!attribute [rw] at_bats
    #   Returns the at-bats
    #   @api public
    #   @example
    #     stats.at_bats #=> 36
    #   @return [Integer] the at-bats
    attribute :at_bats, Shale::Type::Integer

    # @!attribute [rw] avg
    #   Returns the batting average
    #   @api public
    #   @example
    #     stats.avg #=> ".227"
    #   @return [String] the batting average
    attribute :avg, Shale::Type::String

    # @!attribute [rw] rbi
    #   Returns the runs batted in
    #   @api public
    #   @example
    #     stats.rbi #=> 8
    #   @return [Integer] the RBI
    attribute :rbi, Shale::Type::Integer

    # @!attribute [rw] left_on_base
    #   Returns runners left on base
    #   @api public
    #   @example
    #     stats.left_on_base #=> 11
    #   @return [Integer] the left on base
    attribute :left_on_base, Shale::Type::Integer

    json do
      map "runs", to: :runs
      map "hits", to: :hits
      map "doubles", to: :doubles
      map "triples", to: :triples
      map "homeRuns", to: :home_runs
      map "strikeOuts", to: :strike_outs
      map "baseOnBalls", to: :base_on_balls
      map "atBats", to: :at_bats
      map "avg", to: :avg
      map "rbi", to: :rbi
      map "leftOnBase", to: :left_on_base
    end
  end

  # Represents pitching statistics for a team in a boxscore
  class BoxscorePitchingStats < Shale::Mapper
    # @!attribute [rw] runs
    #   Returns runs allowed
    #   @api public
    #   @example
    #     stats.runs #=> 4
    #   @return [Integer] the runs
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] earned_runs
    #   Returns earned runs allowed
    #   @api public
    #   @example
    #     stats.earned_runs #=> 4
    #   @return [Integer] the earned runs
    attribute :earned_runs, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns hits allowed
    #   @api public
    #   @example
    #     stats.hits #=> 7
    #   @return [Integer] the hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns home runs allowed
    #   @api public
    #   @example
    #     stats.home_runs #=> 3
    #   @return [Integer] the home runs
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] strike_outs
    #   Returns strikeouts
    #   @api public
    #   @example
    #     stats.strike_outs #=> 6
    #   @return [Integer] the strikeouts
    attribute :strike_outs, Shale::Type::Integer

    # @!attribute [rw] base_on_balls
    #   Returns walks
    #   @api public
    #   @example
    #     stats.base_on_balls #=> 3
    #   @return [Integer] the walks
    attribute :base_on_balls, Shale::Type::Integer

    # @!attribute [rw] innings_pitched
    #   Returns innings pitched
    #   @api public
    #   @example
    #     stats.innings_pitched #=> "9.0"
    #   @return [String] the innings pitched
    attribute :innings_pitched, Shale::Type::String

    # @!attribute [rw] era
    #   Returns the earned run average
    #   @api public
    #   @example
    #     stats.era #=> "3.84"
    #   @return [String] the ERA
    attribute :era, Shale::Type::String

    json do
      map "runs", to: :runs
      map "earnedRuns", to: :earned_runs
      map "hits", to: :hits
      map "homeRuns", to: :home_runs
      map "strikeOuts", to: :strike_outs
      map "baseOnBalls", to: :base_on_balls
      map "inningsPitched", to: :innings_pitched
      map "era", to: :era
    end
  end

  # Represents team statistics in a boxscore
  class BoxscoreTeamStats < Shale::Mapper
    # @!attribute [rw] batting
    #   Returns batting statistics
    #   @api public
    #   @example
    #     team_stats.batting #=> #<MLB::BoxscoreBattingStats>
    #   @return [BoxscoreBattingStats] the batting stats
    attribute :batting, BoxscoreBattingStats

    # @!attribute [rw] pitching
    #   Returns pitching statistics
    #   @api public
    #   @example
    #     team_stats.pitching #=> #<MLB::BoxscorePitchingStats>
    #   @return [BoxscorePitchingStats] the pitching stats
    attribute :pitching, BoxscorePitchingStats

    json do
      map "batting", to: :batting
      map "pitching", to: :pitching
    end
  end
end
