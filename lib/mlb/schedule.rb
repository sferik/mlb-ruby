require "shale"
require_relative "schedule_date"

module MLB
  # Provides methods for fetching game schedules from the API
  class Schedule < Shale::Mapper
    attribute :total_games, Shale::Type::Integer
    attribute :dates, ScheduleDate, collection: true

    json do
      map "totalGames", to: :total_games
      map "dates", to: :dates
    end

    # Retrieves the schedule for a given date
    #
    # @api public
    # @example Get schedule for a specific date
    #   MLB::Schedule.games(date: Date.new(2024, 7, 4))
    # @example Get schedule for a team on a specific date
    #   MLB::Schedule.games(date: Date.new(2024, 7, 4), team: 147)
    # @param date [Date] the date to get the schedule for
    # @param sport [Sport, Integer] the sport or sport ID (default: MLB)
    # @param team [Team, Integer] optional team or team ID to filter by
    # @return [Array<ScheduledGame>] the list of scheduled games
    def self.games(date: Date.today, sport: Utils::DEFAULT_SPORT_ID, team: nil)
      params = {sportId: Utils.extract_id(sport), date:}
      params[:teamId] = Utils.extract_id(team) if team
      response = CLIENT.get("schedule?#{Utils.build_query(params)}")
      from_json(response).dates.flat_map(&:games)
    end
  end
end
