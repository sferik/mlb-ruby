require "shale"
require_relative "scheduled_game"

module MLB
  # Represents a date within a schedule response
  class ScheduleDate < Shale::Mapper
    # @!attribute [rw] date
    #   Returns the date
    #   @api public
    #   @example
    #     schedule_date.date #=> #<Date: 2024-07-04>
    #   @return [Date] the date
    attribute :date, Shale::Type::Date

    # @!attribute [rw] total_games
    #   Returns the total number of games on this date
    #   @api public
    #   @example
    #     schedule_date.total_games #=> 15
    #   @return [Integer] the total number of games
    attribute :total_games, Shale::Type::Integer

    # @!attribute [rw] games
    #   Returns the games scheduled for this date
    #   @api public
    #   @example
    #     schedule_date.games #=> [#<MLB::ScheduledGame>, ...]
    #   @return [Array<ScheduledGame>] the games scheduled for this date
    attribute :games, ScheduledGame, collection: true

    json do
      map "date", to: :date
      map "totalGames", to: :total_games
      map "games", to: :games
    end
  end
end
