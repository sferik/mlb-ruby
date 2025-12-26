require "shale"
require_relative "schedule_date"

module MLB
  # Provides methods for fetching tied games from the API
  class TiedGames < Shale::Mapper
    # @!attribute [rw] dates
    #   Returns the schedule dates with tied games
    #   @api public
    #   @example
    #     tied_games.dates #=> [#<MLB::ScheduleDate>, ...]
    #   @return [Array<ScheduleDate>] the schedule dates with games
    attribute :dates, ScheduleDate, collection: true

    json do
      map "dates", to: :dates
    end

    # Retrieves tied games for a given season
    #
    # @api public
    # @example Get tied games for a season
    #   MLB::TiedGames.all(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<ScheduledGame>] the list of tied games
    def self.all(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("schedule/games/tied?#{Utils.build_query(season:)}")
      from_json(response).dates.flat_map(&:games)
    end
  end
end
