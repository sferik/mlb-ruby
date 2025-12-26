require "equalizer"
require "shale"
require_relative "team"

module MLB
  # Represents an attendance record for a team
  class AttendanceRecord < Shale::Mapper
    include Equalizer.new(:team, :year)

    # @!attribute [rw] year
    #   Returns the year of the attendance record
    #   @api public
    #   @example
    #     attendance_record.year #=> "2024"
    #   @return [String] the year
    attribute :year, Shale::Type::String

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     attendance_record.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] openings_total
    #   Returns the total number of openings
    #   @api public
    #   @example
    #     attendance_record.openings_total #=> 160
    #   @return [Integer] the total openings
    attribute :openings_total, Shale::Type::Integer

    # @!attribute [rw] openings_total_home
    #   Returns the total home openings
    #   @api public
    #   @example
    #     attendance_record.openings_total_home #=> 79
    #   @return [Integer] the total home openings
    attribute :openings_total_home, Shale::Type::Integer

    # @!attribute [rw] openings_total_away
    #   Returns the total away openings
    #   @api public
    #   @example
    #     attendance_record.openings_total_away #=> 81
    #   @return [Integer] the total away openings
    attribute :openings_total_away, Shale::Type::Integer

    # @!attribute [rw] games_total
    #   Returns the total number of games
    #   @api public
    #   @example
    #     attendance_record.games_total #=> 165
    #   @return [Integer] the total games
    attribute :games_total, Shale::Type::Integer

    # @!attribute [rw] games_home_total
    #   Returns the total home games
    #   @api public
    #   @example
    #     attendance_record.games_home_total #=> 83
    #   @return [Integer] the total home games
    attribute :games_home_total, Shale::Type::Integer

    # @!attribute [rw] games_away_total
    #   Returns the total away games
    #   @api public
    #   @example
    #     attendance_record.games_away_total #=> 82
    #   @return [Integer] the total away games
    attribute :games_away_total, Shale::Type::Integer

    # @!attribute [rw] attendance_total
    #   Returns the total attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_total #=> 5947960
    #   @return [Integer] the total attendance
    attribute :attendance_total, Shale::Type::Integer

    # @!attribute [rw] attendance_total_home
    #   Returns the total home attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_total_home #=> 3309838
    #   @return [Integer] the total home attendance
    attribute :attendance_total_home, Shale::Type::Integer

    # @!attribute [rw] attendance_total_away
    #   Returns the total away attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_total_away #=> 2638122
    #   @return [Integer] the total away attendance
    attribute :attendance_total_away, Shale::Type::Integer

    # @!attribute [rw] attendance_average_home
    #   Returns the average home attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_average_home #=> 41897
    #   @return [Integer] the average home attendance
    attribute :attendance_average_home, Shale::Type::Integer

    # @!attribute [rw] attendance_average_away
    #   Returns the average away attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_average_away #=> 32569
    #   @return [Integer] the average away attendance
    attribute :attendance_average_away, Shale::Type::Integer

    # @!attribute [rw] attendance_average_ytd
    #   Returns the average year-to-date attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_average_ytd #=> 37175
    #   @return [Integer] the average YTD attendance
    attribute :attendance_average_ytd, Shale::Type::Integer

    # @!attribute [rw] attendance_high
    #   Returns the highest single-game attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_high #=> 48760
    #   @return [Integer] the highest attendance
    attribute :attendance_high, Shale::Type::Integer

    # @!attribute [rw] attendance_low
    #   Returns the lowest single-game attendance
    #   @api public
    #   @example
    #     attendance_record.attendance_low #=> 30060
    #   @return [Integer] the lowest attendance
    attribute :attendance_low, Shale::Type::Integer

    json do
      map "year", to: :year
      map "team", to: :team
      map "openingsTotal", to: :openings_total
      map "openingsTotalHome", to: :openings_total_home
      map "openingsTotalAway", to: :openings_total_away
      map "gamesTotal", to: :games_total
      map "gamesHomeTotal", to: :games_home_total
      map "gamesAwayTotal", to: :games_away_total
      map "attendanceTotal", to: :attendance_total
      map "attendanceTotalHome", to: :attendance_total_home
      map "attendanceTotalAway", to: :attendance_total_away
      map "attendanceAverageHome", to: :attendance_average_home
      map "attendanceAverageAway", to: :attendance_average_away
      map "attendanceAverageYtd", to: :attendance_average_ytd
      map "attendanceHigh", to: :attendance_high
      map "attendanceLow", to: :attendance_low
    end
  end
end
