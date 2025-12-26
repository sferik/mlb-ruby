require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a player's batting stats for a game
  class PlayerGameBattingStats < Shale::Mapper
    # @!attribute [rw] games_played
    #   Returns games played
    #   @api public
    #   @example
    #     stats.games_played #=> 1
    #   @return [Integer] games played
    attribute :games_played, Shale::Type::Integer

    # @!attribute [rw] at_bats
    #   Returns at bats
    #   @api public
    #   @example
    #     stats.at_bats #=> 4
    #   @return [Integer] at bats
    attribute :at_bats, Shale::Type::Integer

    # @!attribute [rw] runs
    #   Returns runs scored
    #   @api public
    #   @example
    #     stats.runs #=> 1
    #   @return [Integer] runs
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns hits
    #   @api public
    #   @example
    #     stats.hits #=> 2
    #   @return [Integer] hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] doubles
    #   Returns doubles
    #   @api public
    #   @example
    #     stats.doubles #=> 1
    #   @return [Integer] doubles
    attribute :doubles, Shale::Type::Integer

    # @!attribute [rw] triples
    #   Returns triples
    #   @api public
    #   @example
    #     stats.triples #=> 0
    #   @return [Integer] triples
    attribute :triples, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns home runs
    #   @api public
    #   @example
    #     stats.home_runs #=> 1
    #   @return [Integer] home runs
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] rbi
    #   Returns RBIs
    #   @api public
    #   @example
    #     stats.rbi #=> 3
    #   @return [Integer] RBIs
    attribute :rbi, Shale::Type::Integer

    # @!attribute [rw] stolen_bases
    #   Returns stolen bases
    #   @api public
    #   @example
    #     stats.stolen_bases #=> 0
    #   @return [Integer] stolen bases
    attribute :stolen_bases, Shale::Type::Integer

    # @!attribute [rw] base_on_balls
    #   Returns walks
    #   @api public
    #   @example
    #     stats.base_on_balls #=> 1
    #   @return [Integer] walks
    attribute :base_on_balls, Shale::Type::Integer

    # @!attribute [rw] strike_outs
    #   Returns strikeouts
    #   @api public
    #   @example
    #     stats.strike_outs #=> 1
    #   @return [Integer] strikeouts
    attribute :strike_outs, Shale::Type::Integer

    json do
      map "gamesPlayed", to: :games_played
      map "atBats", to: :at_bats
      map "runs", to: :runs
      map "hits", to: :hits
      map "doubles", to: :doubles
      map "triples", to: :triples
      map "homeRuns", to: :home_runs
      map "rbi", to: :rbi
      map "stolenBases", to: :stolen_bases
      map "baseOnBalls", to: :base_on_balls
      map "strikeOuts", to: :strike_outs
    end
  end

  # Represents a player's pitching stats for a game
  class PlayerGamePitchingStats < Shale::Mapper
    # @!attribute [rw] games_played
    #   Returns games played
    #   @api public
    #   @example
    #     stats.games_played #=> 1
    #   @return [Integer] games played
    attribute :games_played, Shale::Type::Integer

    # @!attribute [rw] games_started
    #   Returns games started
    #   @api public
    #   @example
    #     stats.games_started #=> 1
    #   @return [Integer] games started
    attribute :games_started, Shale::Type::Integer

    # @!attribute [rw] wins
    #   Returns wins
    #   @api public
    #   @example
    #     stats.wins #=> 1
    #   @return [Integer] wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns losses
    #   @api public
    #   @example
    #     stats.losses #=> 0
    #   @return [Integer] losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] saves
    #   Returns saves
    #   @api public
    #   @example
    #     stats.saves #=> 0
    #   @return [Integer] saves
    attribute :saves, Shale::Type::Integer

    # @!attribute [rw] innings_pitched
    #   Returns innings pitched
    #   @api public
    #   @example
    #     stats.innings_pitched #=> "7.0"
    #   @return [String] innings pitched
    attribute :innings_pitched, Shale::Type::String

    # @!attribute [rw] hits
    #   Returns hits allowed
    #   @api public
    #   @example
    #     stats.hits #=> 5
    #   @return [Integer] hits allowed
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] runs
    #   Returns runs allowed
    #   @api public
    #   @example
    #     stats.runs #=> 2
    #   @return [Integer] runs allowed
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] earned_runs
    #   Returns earned runs
    #   @api public
    #   @example
    #     stats.earned_runs #=> 2
    #   @return [Integer] earned runs
    attribute :earned_runs, Shale::Type::Integer

    # @!attribute [rw] home_runs
    #   Returns home runs allowed
    #   @api public
    #   @example
    #     stats.home_runs #=> 1
    #   @return [Integer] home runs allowed
    attribute :home_runs, Shale::Type::Integer

    # @!attribute [rw] base_on_balls
    #   Returns walks
    #   @api public
    #   @example
    #     stats.base_on_balls #=> 2
    #   @return [Integer] walks
    attribute :base_on_balls, Shale::Type::Integer

    # @!attribute [rw] strike_outs
    #   Returns strikeouts
    #   @api public
    #   @example
    #     stats.strike_outs #=> 8
    #   @return [Integer] strikeouts
    attribute :strike_outs, Shale::Type::Integer

    # @!attribute [rw] number_of_pitches
    #   Returns pitch count
    #   @api public
    #   @example
    #     stats.number_of_pitches #=> 95
    #   @return [Integer] pitch count
    attribute :number_of_pitches, Shale::Type::Integer

    json do
      map "gamesPlayed", to: :games_played
      map "gamesStarted", to: :games_started
      map "wins", to: :wins
      map "losses", to: :losses
      map "saves", to: :saves
      map "inningsPitched", to: :innings_pitched
      map "hits", to: :hits
      map "runs", to: :runs
      map "earnedRuns", to: :earned_runs
      map "homeRuns", to: :home_runs
      map "baseOnBalls", to: :base_on_balls
      map "strikeOuts", to: :strike_outs
      map "numberOfPitches", to: :number_of_pitches
    end
  end

  # Represents a player's stat split for a game
  class PlayerGameStatSplit < Shale::Mapper
    # @!attribute [rw] stat
    #   Returns the batting stats
    #   @api public
    #   @example
    #     split.stat #=> #<MLB::PlayerGameBattingStats>
    #   @return [PlayerGameBattingStats, PlayerGamePitchingStats] the stats
    attribute :stat, Shale::Type::Value

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     split.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] player
    #   Returns the player
    #   @api public
    #   @example
    #     split.player #=> #<MLB::Player>
    #   @return [Player] the player
    attribute :player, Player

    json do
      map "stat", to: :stat
      map "team", to: :team
      map "player", to: :player
    end
  end

  # Represents a stat group for a player's game
  class PlayerGameStatGroup < Shale::Mapper
    # @!attribute [rw] group
    #   Returns the stat group name
    #   @api public
    #   @example
    #     group.group #=> "hitting"
    #   @return [String] the group name
    attribute :group, Shale::Type::String

    # @!attribute [rw] splits
    #   Returns the stat splits
    #   @api public
    #   @example
    #     group.splits #=> [#<MLB::PlayerGameStatSplit>, ...]
    #   @return [Array<PlayerGameStatSplit>] the splits
    attribute :splits, PlayerGameStatSplit, collection: true

    json do
      map "group", to: :group
      map "splits", to: :splits
    end
  end

  # Provides methods for fetching player game stats from the API
  class PlayerGameStats < Shale::Mapper
    # @!attribute [rw] stats
    #   Returns the stat groups
    #   @api public
    #   @example
    #     stats.stats #=> [#<MLB::PlayerGameStatGroup>, ...]
    #   @return [Array<PlayerGameStatGroup>] the stat groups
    attribute :stats, PlayerGameStatGroup, collection: true

    json do
      map "stats", to: :stats
    end

    # Retrieves a player's stats for a specific game
    #
    # @api public
    # @example Get player stats for a game
    #   MLB::PlayerGameStats.find(player: 660271, game: 745571)
    # @example Get stats using Player and ScheduledGame objects
    #   MLB::PlayerGameStats.find(player: player, game: game)
    # @param player [Integer, Player] the player ID or player object
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [PlayerGameStats] the player's game stats
    def self.find(player:, game:)
      player_id = Utils.extract_id(player)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("people/#{player_id}/stats/game/#{game_pk}")
      from_json(response)
    end

    # Returns the batting stats from the response
    #
    # @api public
    # @example Get batting stats
    #   stats.batting #=> #<MLB::PlayerGameBattingStats>
    # @return [PlayerGameBattingStats, nil] the batting stats
    def batting
      batting_group = stats.find { |s| s.group.eql?("hitting") }
      split = batting_group&.splits&.first
      return nil unless split

      PlayerGameBattingStats.from_json(split.stat.to_json)
    end

    # Returns the pitching stats from the response
    #
    # @api public
    # @example Get pitching stats
    #   stats.pitching #=> #<MLB::PlayerGamePitchingStats>
    # @return [PlayerGamePitchingStats, nil] the pitching stats
    def pitching
      pitching_group = stats.find { |s| s.group.eql?("pitching") }
      split = pitching_group&.splits&.first
      return nil unless split

      PlayerGamePitchingStats.from_json(split.stat.to_json)
    end
  end
end
