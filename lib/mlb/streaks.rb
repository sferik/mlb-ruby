require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a player's active streak (hitting streak, on-base streak, etc.)
  class PlayerStreak < Shale::Mapper
    include Equalizer.new(:player_id, :streak_type, :current_streak)

    # Streak type for hitting streaks
    STREAK_HITTING = "hittingStreak".freeze
    # Streak type for on-base streaks
    STREAK_ON_BASE = "onBaseStreak".freeze

    # @!attribute [rw] player_id
    #   Returns the player ID
    #   @api public
    #   @example
    #     streak.player_id #=> 660271
    #   @return [Integer] the player ID
    attribute :player_id, Shale::Type::Integer

    # @!attribute [rw] player_name
    #   Returns the player name
    #   @api public
    #   @example
    #     streak.player_name #=> "Shohei Ohtani"
    #   @return [String] the player name
    attribute :player_name, Shale::Type::String

    # @!attribute [rw] streak_type
    #   Returns the streak type
    #   @api public
    #   @example
    #     streak.streak_type #=> "hittingStreak"
    #   @return [String] the streak type
    attribute :streak_type, Shale::Type::String

    # @!attribute [rw] current_streak
    #   Returns the current streak length
    #   @api public
    #   @example
    #     streak.current_streak #=> 15
    #   @return [Integer] the current streak
    attribute :current_streak, Shale::Type::Integer

    # @!attribute [rw] current_streak_stat
    #   Returns the stat during the streak
    #   @api public
    #   @example
    #     streak.current_streak_stat #=> "20-for-58"
    #   @return [String] the streak stat
    attribute :current_streak_stat, Shale::Type::String

    # @!attribute [rw] team
    #   Returns the player's team
    #   @api public
    #   @example
    #     streak.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # Returns whether this is a hitting streak
    #
    # @api public
    # @example
    #   streak.hitting_streak? #=> true
    # @return [Boolean] whether this is a hitting streak
    def hitting_streak? = streak_type.eql?(STREAK_HITTING)

    # Returns whether this is an on-base streak
    #
    # @api public
    # @example
    #   streak.on_base_streak? #=> false
    # @return [Boolean] whether this is an on-base streak
    def on_base_streak? = streak_type.eql?(STREAK_ON_BASE)

    json do
      map "playerId", to: :player_id
      map "playerName", to: :player_name
      map "streakType", to: :streak_type
      map "currentStreak", to: :current_streak
      map "currentStreakStat", to: :current_streak_stat
      map "team", to: :team
    end
  end

  # Represents a streaks category
  class StreakCategory < Shale::Mapper
    # Category type for hitting streaks
    CATEGORY_HITTING = "hittingStreak".freeze
    # Category type for on-base streaks
    CATEGORY_ON_BASE = "onBaseStreak".freeze

    # @!attribute [rw] category_type
    #   Returns the streak category type
    #   @api public
    #   @example
    #     category.category_type #=> "hittingStreak"
    #   @return [String] the category type
    attribute :category_type, Shale::Type::String

    # @!attribute [rw] streaks
    #   Returns the streaks
    #   @api public
    #   @example
    #     category.streaks #=> [#<MLB::PlayerStreak>, ...]
    #   @return [Array<PlayerStreak>] the streaks
    attribute :streaks, PlayerStreak, collection: true

    # Returns whether this is a hitting streak category
    #
    # @api public
    # @example
    #   category.hitting_streak? #=> true
    # @return [Boolean] whether this is a hitting streak category
    def hitting_streak? = category_type.eql?(CATEGORY_HITTING)

    # Returns whether this is an on-base streak category
    #
    # @api public
    # @example
    #   category.on_base_streak? #=> false
    # @return [Boolean] whether this is an on-base streak category
    def on_base_streak? = category_type.eql?(CATEGORY_ON_BASE)

    json do
      map "streakType", to: :category_type
      map "streaks", to: :streaks
    end
  end

  # Provides methods for fetching streak data from the API
  class Streaks < Shale::Mapper
    # @!attribute [rw] streak_stats
    #   Returns the streak categories
    #   @api public
    #   @example
    #     streaks.streak_stats #=> [#<MLB::StreakCategory>, ...]
    #   @return [Array<StreakCategory>] the streak categories
    attribute :streak_stats, StreakCategory, collection: true

    json do
      map "streakStats", to: :streak_stats
    end

    # Retrieves hitting streaks
    #
    # @api public
    # @example Get current hitting streaks
    #   MLB::Streaks.hitting(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param limit [Integer] the maximum number of results (defaults to 10)
    # @return [Array<PlayerStreak>] the hitting streaks
    def self.hitting(season: nil, limit: 10)
      find(streak_type: "hittingStreak", season:, limit:)
    end

    # Retrieves on-base streaks
    #
    # @api public
    # @example Get current on-base streaks
    #   MLB::Streaks.on_base(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param limit [Integer] the maximum number of results (defaults to 10)
    # @return [Array<PlayerStreak>] the on-base streaks
    def self.on_base(season: nil, limit: 10)
      find(streak_type: "onBaseStreak", season:, limit:)
    end

    # Retrieves streaks by type
    #
    # @api public
    # @example Get hitting streaks
    #   MLB::Streaks.find(streak_type: "hittingStreak", season: 2024)
    # @param streak_type [String] the streak type
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param limit [Integer] the maximum number of results (defaults to 10)
    # @return [Array<PlayerStreak>] the streaks
    def self.find(streak_type:, season: nil, limit: 10)
      season ||= Utils.current_season
      params = {streakType: streak_type, season:, limit:}
      response = CLIENT.get("stats/streaks?#{Utils.build_query(params)}")
      from_json(response).streak_stats.first&.streaks || []
    end
  end
end
