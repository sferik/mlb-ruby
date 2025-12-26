require "shale"
require_relative "player"
require_relative "handedness"

module MLB
  # Represents the result of a play
  class PlayResult < Shale::Mapper
    # @!attribute [rw] type
    #   Returns the result type
    #   @api public
    #   @example
    #     result.type #=> "atBat"
    #   @return [String] the result type
    attribute :type, Shale::Type::String

    # @!attribute [rw] event
    #   Returns the event name
    #   @api public
    #   @example
    #     result.event #=> "Groundout"
    #   @return [String] the event name
    attribute :event, Shale::Type::String

    # @!attribute [rw] event_type
    #   Returns the event type code
    #   @api public
    #   @example
    #     result.event_type #=> "field_out"
    #   @return [String] the event type code
    attribute :event_type, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the description
    #   @api public
    #   @example
    #     result.description #=> "Francisco Lindor grounds out..."
    #   @return [String] the description
    attribute :description, Shale::Type::String

    # @!attribute [rw] rbi
    #   Returns the RBIs on this play
    #   @api public
    #   @example
    #     result.rbi #=> 0
    #   @return [Integer] the RBIs
    attribute :rbi, Shale::Type::Integer

    # @!attribute [rw] away_score
    #   Returns the away score after this play
    #   @api public
    #   @example
    #     result.away_score #=> 0
    #   @return [Integer] the away score
    attribute :away_score, Shale::Type::Integer

    # @!attribute [rw] home_score
    #   Returns the home score after this play
    #   @api public
    #   @example
    #     result.home_score #=> 0
    #   @return [Integer] the home score
    attribute :home_score, Shale::Type::Integer

    # @!attribute [rw] is_out
    #   Returns whether this play resulted in an out
    #   @api public
    #   @example
    #     result.out? #=> true
    #   @return [Boolean] whether an out occurred
    attribute :is_out, Shale::Type::Boolean

    # Returns whether this play resulted in an out
    #
    # @api public
    # @example
    #   result.out? #=> true
    # @return [Boolean] whether an out occurred
    def out?
      is_out
    end

    json do
      map "type", to: :type
      map "event", to: :event
      map "eventType", to: :event_type
      map "description", to: :description
      map "rbi", to: :rbi
      map "awayScore", to: :away_score
      map "homeScore", to: :home_score
      map "isOut", to: :is_out
    end
  end

  # Represents information about a play
  class PlayAbout < Shale::Mapper
    # @!attribute [rw] at_bat_index
    #   Returns the at bat index
    #   @api public
    #   @example
    #     about.at_bat_index #=> 0
    #   @return [Integer] the at bat index
    attribute :at_bat_index, Shale::Type::Integer

    # @!attribute [rw] half_inning
    #   Returns the half inning
    #   @api public
    #   @example
    #     about.half_inning #=> "top"
    #   @return [String] the half inning
    attribute :half_inning, Shale::Type::String

    # @!attribute [rw] is_top_inning
    #   Returns whether it's the top of the inning
    #   @api public
    #   @example
    #     about.top_inning? #=> true
    #   @return [Boolean] whether top of inning
    attribute :is_top_inning, Shale::Type::Boolean

    # @!attribute [rw] inning
    #   Returns the inning number
    #   @api public
    #   @example
    #     about.inning #=> 1
    #   @return [Integer] the inning
    attribute :inning, Shale::Type::Integer

    # @!attribute [rw] is_complete
    #   Returns whether the play is complete
    #   @api public
    #   @example
    #     about.complete? #=> true
    #   @return [Boolean] whether complete
    attribute :is_complete, Shale::Type::Boolean

    # @!attribute [rw] is_scoring_play
    #   Returns whether this is a scoring play
    #   @api public
    #   @example
    #     about.scoring_play? #=> false
    #   @return [Boolean] whether a scoring play
    attribute :is_scoring_play, Shale::Type::Boolean

    # Returns whether it's the top of the inning
    #
    # @api public
    # @example
    #   about.top_inning? #=> true
    # @return [Boolean] whether top of inning
    def top_inning?
      is_top_inning
    end

    # Returns whether the play is complete
    #
    # @api public
    # @example
    #   about.complete? #=> true
    # @return [Boolean] whether complete
    def complete?
      is_complete
    end

    # Returns whether this is a scoring play
    #
    # @api public
    # @example
    #   about.scoring_play? #=> false
    # @return [Boolean] whether a scoring play
    def scoring_play?
      is_scoring_play
    end

    json do
      map "atBatIndex", to: :at_bat_index
      map "halfInning", to: :half_inning
      map "isTopInning", to: :is_top_inning
      map "inning", to: :inning
      map "isComplete", to: :is_complete
      map "isScoringPlay", to: :is_scoring_play
    end
  end

  # Represents the count during a play
  class PlayCount < Shale::Mapper
    # @!attribute [rw] balls
    #   Returns the ball count
    #   @api public
    #   @example
    #     count.balls #=> 1
    #   @return [Integer] the balls
    attribute :balls, Shale::Type::Integer

    # @!attribute [rw] strikes
    #   Returns the strike count
    #   @api public
    #   @example
    #     count.strikes #=> 1
    #   @return [Integer] the strikes
    attribute :strikes, Shale::Type::Integer

    # @!attribute [rw] outs
    #   Returns the out count
    #   @api public
    #   @example
    #     count.outs #=> 1
    #   @return [Integer] the outs
    attribute :outs, Shale::Type::Integer

    json do
      map "balls", to: :balls
      map "strikes", to: :strikes
      map "outs", to: :outs
    end
  end

  # Represents the matchup during a play
  class PlayMatchup < Shale::Mapper
    # @!attribute [rw] batter
    #   Returns the batter
    #   @api public
    #   @example
    #     matchup.batter #=> #<MLB::Player>
    #   @return [Player] the batter
    attribute :batter, Player

    # @!attribute [rw] bat_side
    #   Returns the bat side
    #   @api public
    #   @example
    #     matchup.bat_side #=> #<MLB::Handedness>
    #   @return [Handedness] the bat side
    attribute :bat_side, Handedness

    # @!attribute [rw] pitcher
    #   Returns the pitcher
    #   @api public
    #   @example
    #     matchup.pitcher #=> #<MLB::Player>
    #   @return [Player] the pitcher
    attribute :pitcher, Player

    # @!attribute [rw] pitch_hand
    #   Returns the pitch hand
    #   @api public
    #   @example
    #     matchup.pitch_hand #=> #<MLB::Handedness>
    #   @return [Handedness] the pitch hand
    attribute :pitch_hand, Handedness

    json do
      map "batter", to: :batter
      map "batSide", to: :bat_side
      map "pitcher", to: :pitcher
      map "pitchHand", to: :pitch_hand
    end
  end

  # Represents a play in a game
  class Play < Shale::Mapper
    # @!attribute [rw] result
    #   Returns the play result
    #   @api public
    #   @example
    #     play.result #=> #<MLB::PlayResult>
    #   @return [PlayResult] the result
    attribute :result, PlayResult

    # @!attribute [rw] about
    #   Returns the play info
    #   @api public
    #   @example
    #     play.about #=> #<MLB::PlayAbout>
    #   @return [PlayAbout] the info
    attribute :about, PlayAbout

    # @!attribute [rw] count
    #   Returns the count
    #   @api public
    #   @example
    #     play.count #=> #<MLB::PlayCount>
    #   @return [PlayCount] the count
    attribute :count, PlayCount

    # @!attribute [rw] matchup
    #   Returns the matchup
    #   @api public
    #   @example
    #     play.matchup #=> #<MLB::PlayMatchup>
    #   @return [PlayMatchup] the matchup
    attribute :matchup, PlayMatchup

    json do
      map "result", to: :result
      map "about", to: :about
      map "count", to: :count
      map "matchup", to: :matchup
    end
  end
end
