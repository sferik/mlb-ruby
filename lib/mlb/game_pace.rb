require "shale"
require_relative "sport"

module MLB
  # Represents game pace statistics
  class GamePaceStats < Shale::Mapper
    # @!attribute [rw] hits_per_9inn
    #   Returns hits per 9 innings
    #   @api public
    #   @example
    #     stats.hits_per_9inn #=> 16.63
    #   @return [Float] the hits per 9 innings
    attribute :hits_per_9inn, Shale::Type::Float

    # @!attribute [rw] runs_per_9inn
    #   Returns runs per 9 innings
    #   @api public
    #   @example
    #     stats.runs_per_9inn #=> 8.91
    #   @return [Float] the runs per 9 innings
    attribute :runs_per_9inn, Shale::Type::Float

    # @!attribute [rw] pitches_per_9inn
    #   Returns pitches per 9 innings
    #   @api public
    #   @example
    #     stats.pitches_per_9inn #=> 296.2
    #   @return [Float] the pitches per 9 innings
    attribute :pitches_per_9inn, Shale::Type::Float

    # @!attribute [rw] hits_per_game
    #   Returns hits per game
    #   @api public
    #   @example
    #     stats.hits_per_game #=> 16.39
    #   @return [Float] the hits per game
    attribute :hits_per_game, Shale::Type::Float

    # @!attribute [rw] runs_per_game
    #   Returns runs per game
    #   @api public
    #   @example
    #     stats.runs_per_game #=> 8.79
    #   @return [Float] the runs per game
    attribute :runs_per_game, Shale::Type::Float

    # @!attribute [rw] pitches_per_game
    #   Returns pitches per game
    #   @api public
    #   @example
    #     stats.pitches_per_game #=> 292.1
    #   @return [Float] the pitches per game
    attribute :pitches_per_game, Shale::Type::Float

    # @!attribute [rw] total_games
    #   Returns total games
    #   @api public
    #   @example
    #     stats.total_games #=> 2429
    #   @return [Integer] the total games
    attribute :total_games, Shale::Type::Integer

    # @!attribute [rw] total_innings_played
    #   Returns total innings played
    #   @api public
    #   @example
    #     stats.total_innings_played #=> 21626.5
    #   @return [Float] the total innings
    attribute :total_innings_played, Shale::Type::Float

    # @!attribute [rw] total_hits
    #   Returns total hits
    #   @api public
    #   @example
    #     stats.total_hits #=> 39823
    #   @return [Integer] the total hits
    attribute :total_hits, Shale::Type::Integer

    # @!attribute [rw] total_runs
    #   Returns total runs
    #   @api public
    #   @example
    #     stats.total_runs #=> 21343
    #   @return [Integer] the total runs
    attribute :total_runs, Shale::Type::Integer

    # @!attribute [rw] total_pitches
    #   Returns total pitches
    #   @api public
    #   @example
    #     stats.total_pitches #=> 709511
    #   @return [Integer] the total pitches
    attribute :total_pitches, Shale::Type::Integer

    # @!attribute [rw] time_per_game
    #   Returns average time per game
    #   @api public
    #   @example
    #     stats.time_per_game #=> "02:38:44"
    #   @return [String] the time per game
    attribute :time_per_game, Shale::Type::String

    # @!attribute [rw] time_per_pitch
    #   Returns average time per pitch
    #   @api public
    #   @example
    #     stats.time_per_pitch #=> "00:00:32"
    #   @return [String] the time per pitch
    attribute :time_per_pitch, Shale::Type::String

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     stats.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] sport
    #   Returns the sport
    #   @api public
    #   @example
    #     stats.sport #=> #<MLB::Sport>
    #   @return [Sport] the sport
    attribute :sport, Sport

    json do
      map "hitsPer9Inn", to: :hits_per_9inn
      map "runsPer9Inn", to: :runs_per_9inn
      map "pitchesPer9Inn", to: :pitches_per_9inn
      map "hitsPerGame", to: :hits_per_game
      map "runsPerGame", to: :runs_per_game
      map "pitchesPerGame", to: :pitches_per_game
      map "totalGames", to: :total_games
      map "totalInningsPlayed", to: :total_innings_played
      map "totalHits", to: :total_hits
      map "totalRuns", to: :total_runs
      map "totalPitches", to: :total_pitches
      map "timePerGame", to: :time_per_game
      map "timePerPitch", to: :time_per_pitch
      map "season", to: :season
      map "sport", to: :sport
    end
  end

  # Provides methods for fetching game pace data from the API
  class GamePace < Shale::Mapper
    # @!attribute [rw] sports
    #   Returns the sports game pace data
    #   @api public
    #   @example
    #     game_pace.sports #=> [#<MLB::GamePaceStats>, ...]
    #   @return [Array<GamePaceStats>] the sports data
    attribute :sports, GamePaceStats, collection: true

    json do
      map "sports", to: :sports
    end

    # Retrieves game pace statistics for a season
    #
    # @api public
    # @example Get game pace for 2024
    #   MLB::GamePace.find(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [GamePaceStats] the game pace stats for MLB
    def self.find(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("gamePace?#{Utils.build_query(season:)}")
      from_json(response).sports.first
    end
  end
end
