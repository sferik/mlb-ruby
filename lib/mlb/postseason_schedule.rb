require "shale"
require_relative "schedule_date"

module MLB
  # Provides methods for fetching postseason schedule data from the API
  class PostseasonSchedule < Shale::Mapper
    # @!attribute [rw] total_games
    #   Returns the total number of games
    #   @api public
    #   @example
    #     schedule.total_games #=> 43
    #   @return [Integer] the total games
    attribute :total_games, Shale::Type::Integer

    # @!attribute [rw] dates
    #   Returns the schedule dates
    #   @api public
    #   @example
    #     schedule.dates #=> [#<MLB::ScheduleDate>, ...]
    #   @return [Array<ScheduleDate>] the dates
    attribute :dates, ScheduleDate, collection: true

    json do
      map "totalGames", to: :total_games
      map "dates", to: :dates
    end

    # Retrieves postseason games for a season
    #
    # @api public
    # @example Get postseason games for 2024
    #   MLB::PostseasonSchedule.games(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<ScheduledGame>] the postseason games
    def self.games(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("schedule/postseason?#{Utils.build_query(season:)}")
      from_json(response).dates.flat_map(&:games)
    end
  end
end
