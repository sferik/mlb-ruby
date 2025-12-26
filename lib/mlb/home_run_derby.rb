require "shale"
require_relative "player"

module MLB
  # Represents a home run in the derby
  class DerbyHomeRun < Shale::Mapper
    # @!attribute [rw] total_distance
    #   Returns the total distance of the home run
    #   @api public
    #   @example
    #     hr.total_distance #=> 450
    #   @return [Integer] the distance in feet
    attribute :total_distance, Shale::Type::Integer

    # @!attribute [rw] launch_speed
    #   Returns the launch speed
    #   @api public
    #   @example
    #     hr.launch_speed #=> 112.5
    #   @return [Float] the launch speed in mph
    attribute :launch_speed, Shale::Type::Float

    # @!attribute [rw] launch_angle
    #   Returns the launch angle
    #   @api public
    #   @example
    #     hr.launch_angle #=> 28.5
    #   @return [Float] the launch angle in degrees
    attribute :launch_angle, Shale::Type::Float

    # @!attribute [rw] is_bonus_time
    #   Returns whether this was hit during bonus time
    #   @api public
    #   @example
    #     hr.bonus_time? #=> false
    #   @return [Boolean] whether bonus time
    attribute :is_bonus_time, Shale::Type::Boolean

    # Returns whether this home run was during bonus time
    #
    # @api public
    # @example
    #   hr.bonus_time? #=> false
    # @return [Boolean] whether bonus time
    def bonus_time?
      is_bonus_time
    end

    json do
      map "totalDistance", to: :total_distance
      map "launchSpeed", to: :launch_speed
      map "launchAngle", to: :launch_angle
      map "isBonusTime", to: :is_bonus_time
    end
  end

  # Represents a batter's derby performance
  class DerbyBatter < Shale::Mapper
    include Equalizer.new(:id, :seed)

    # @!attribute [rw] id
    #   Returns the player ID
    #   @api public
    #   @example
    #     batter.id #=> 660271
    #   @return [Integer] the player ID
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] full_name
    #   Returns the player's full name
    #   @api public
    #   @example
    #     batter.full_name #=> "Shohei Ohtani"
    #   @return [String] the full name
    attribute :full_name, Shale::Type::String

    # @!attribute [rw] link
    #   Returns the API link to the player
    #   @api public
    #   @example
    #     batter.link #=> "/api/v1/people/660271"
    #   @return [String] the link
    attribute :link, Shale::Type::String

    # @!attribute [rw] seed
    #   Returns the batter's seed
    #   @api public
    #   @example
    #     batter.seed #=> 1
    #   @return [Integer] the seed
    attribute :seed, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns the number of home runs
    #   @api public
    #   @example
    #     batter.home_runs #=> 24
    #   @return [Integer] the home run count
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] is_winner
    #   Returns whether this batter won their matchup
    #   @api public
    #   @example
    #     batter.winner? #=> true
    #   @return [Boolean] whether winner
    attribute :is_winner, Shale::Type::Boolean

    # @!attribute [rw] is_bonus
    #   Returns whether batter earned bonus time
    #   @api public
    #   @example
    #     batter.bonus? #=> true
    #   @return [Boolean] whether bonus earned
    attribute :is_bonus, Shale::Type::Boolean

    # @!attribute [rw] hits
    #   Returns the home run details
    #   @api public
    #   @example
    #     batter.hits #=> [#<MLB::DerbyHomeRun>, ...]
    #   @return [Array<DerbyHomeRun>] the home runs
    attribute :hits, DerbyHomeRun, collection: true

    # Returns whether this batter won their matchup
    #
    # @api public
    # @example
    #   batter.winner? #=> true
    # @return [Boolean] whether winner
    def winner?
      is_winner
    end

    # Returns whether this batter earned bonus time
    #
    # @api public
    # @example
    #   batter.bonus? #=> true
    # @return [Boolean] whether bonus earned
    def bonus?
      is_bonus
    end

    json do
      map "id", to: :id
      map "fullName", to: :full_name
      map "link", to: :link
      map "seed", to: :seed
      map "homeRuns", to: :home_runs
      map "isWinner", to: :is_winner
      map "isBonus", to: :is_bonus
      map "hits", to: :hits
    end
  end

  # Represents a matchup in the derby round
  class DerbyMatchup < Shale::Mapper
    # @!attribute [rw] matchup_id
    #   Returns the matchup ID
    #   @api public
    #   @example
    #     matchup.matchup_id #=> 1
    #   @return [Integer] the matchup ID
    attribute :matchup_id, Shale::Type::Integer

    # @!attribute [rw] top_seed
    #   Returns the top seed batter
    #   @api public
    #   @example
    #     matchup.top_seed #=> #<MLB::DerbyBatter>
    #   @return [DerbyBatter] the top seed
    attribute :top_seed, DerbyBatter

    # @!attribute [rw] bottom_seed
    #   Returns the bottom seed batter
    #   @api public
    #   @example
    #     matchup.bottom_seed #=> #<MLB::DerbyBatter>
    #   @return [DerbyBatter] the bottom seed
    attribute :bottom_seed, DerbyBatter

    json do
      map "matchupId", to: :matchup_id
      map "topSeed", to: :top_seed
      map "bottomSeed", to: :bottom_seed
    end
  end

  # Represents a round in the derby
  class DerbyRound < Shale::Mapper
    # @!attribute [rw] round
    #   Returns the round number
    #   @api public
    #   @example
    #     round.round #=> 1
    #   @return [Integer] the round number
    attribute :round, Shale::Type::Integer

    # @!attribute [rw] num_batters
    #   Returns the number of batters
    #   @api public
    #   @example
    #     round.num_batters #=> 8
    #   @return [Integer] the number of batters
    attribute :num_batters, Shale::Type::Integer

    # @!attribute [rw] matchups
    #   Returns the matchups
    #   @api public
    #   @example
    #     round.matchups #=> [#<MLB::DerbyMatchup>, ...]
    #   @return [Array<DerbyMatchup>] the matchups
    attribute :matchups, DerbyMatchup, collection: true

    json do
      map "round", to: :round
      map "numBatters", to: :num_batters
      map "matchups", to: :matchups
    end
  end

  # Represents home run derby info
  class DerbyInfo < Shale::Mapper
    # @!attribute [rw] id
    #   Returns the derby ID
    #   @api public
    #   @example
    #     info.id #=> 511101
    #   @return [Integer] the ID
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] name
    #   Returns the derby name
    #   @api public
    #   @example
    #     info.name #=> "2024 Home Run Derby"
    #   @return [String] the name
    attribute :name, Shale::Type::String

    json do
      map "id", to: :id
      map "name", to: :name
    end
  end

  # Represents home run derby data
  class HomeRunDerby < Shale::Mapper
    # @!attribute [rw] info
    #   Returns the derby info
    #   @api public
    #   @example
    #     derby.info #=> #<MLB::DerbyInfo>
    #   @return [DerbyInfo] the info
    attribute :info, DerbyInfo

    # @!attribute [rw] rounds
    #   Returns the rounds
    #   @api public
    #   @example
    #     derby.rounds #=> [#<MLB::DerbyRound>, ...]
    #   @return [Array<DerbyRound>] the rounds
    attribute :rounds, DerbyRound, collection: true

    json do
      map "info", to: :info
      map "rounds", to: :rounds
    end

    # Retrieves home run derby data for a game
    #
    # @api public
    # @example Get derby data for a game
    #   MLB::HomeRunDerby.find(game: 511101)
    # @example Get derby data using a ScheduledGame object
    #   MLB::HomeRunDerby.find(game: scheduled_game)
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [HomeRunDerby] the derby data
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("homeRunDerby/#{game_pk}")
      from_json(response)
    end
  end
end
