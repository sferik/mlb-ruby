require "shale"

module MLB
  # Represents the score for one side of an inning
  class InningHalfScore < Shale::Mapper
    # @!attribute [rw] runs
    #   Returns the runs scored
    #   @api public
    #   @example
    #     inning_half_score.runs #=> 2
    #   @return [Integer] the runs
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns the hits
    #   @api public
    #   @example
    #     inning_half_score.hits #=> 3
    #   @return [Integer] the hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] errors
    #   Returns the errors
    #   @api public
    #   @example
    #     inning_half_score.errors #=> 0
    #   @return [Integer] the errors
    attribute :errors, Shale::Type::Integer

    # @!attribute [rw] left_on_base
    #   Returns runners left on base
    #   @api public
    #   @example
    #     inning_half_score.left_on_base #=> 1
    #   @return [Integer] the left on base
    attribute :left_on_base, Shale::Type::Integer

    json do
      map "runs", to: :runs
      map "hits", to: :hits
      map "errors", to: :errors
      map "leftOnBase", to: :left_on_base
    end
  end

  # Represents the score for one inning
  class InningScore < Shale::Mapper
    # @!attribute [rw] num
    #   Returns the inning number
    #   @api public
    #   @example
    #     inning_score.num #=> 1
    #   @return [Integer] the inning number
    attribute :num, Shale::Type::Integer

    # @!attribute [rw] ordinal_num
    #   Returns the ordinal inning number
    #   @api public
    #   @example
    #     inning_score.ordinal_num #=> "1st"
    #   @return [String] the ordinal number
    attribute :ordinal_num, Shale::Type::String

    # @!attribute [rw] home
    #   Returns the home team's score
    #   @api public
    #   @example
    #     inning_score.home #=> #<MLB::InningHalfScore>
    #   @return [InningHalfScore] the home score
    attribute :home, InningHalfScore

    # @!attribute [rw] away
    #   Returns the away team's score
    #   @api public
    #   @example
    #     inning_score.away #=> #<MLB::InningHalfScore>
    #   @return [InningHalfScore] the away score
    attribute :away, InningHalfScore

    json do
      map "num", to: :num
      map "ordinalNum", to: :ordinal_num
      map "home", to: :home
      map "away", to: :away
    end
  end
end
