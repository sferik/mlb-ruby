require "shale"
require_relative "attendance_record"

module MLB
  # Provides methods for fetching attendance data from the API
  class Attendance < Shale::Mapper
    attribute :records, AttendanceRecord, collection: true

    json do
      map "records", to: :records
    end

    # Retrieves attendance data for a team
    #
    # @api public
    # @example Get attendance for a team
    #   MLB::Attendance.find(team: 147, season: 2024)
    # @param team [Team, Integer] the team or team ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<AttendanceRecord>] the attendance records
    def self.find(team:, season: nil)
      season ||= Utils.current_season
      params = {teamId: Utils.extract_id(team), season:}
      response = CLIENT.get("attendance?#{Utils.build_query(params)}")
      from_json(response).records
    end
  end
end
