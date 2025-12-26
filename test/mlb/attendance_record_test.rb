require_relative "../test_helper"

module MLB
  class AttendanceRecordTest < Minitest::Test
    cover AttendanceRecord

    def test_equality
      record1 = AttendanceRecord.new(team: Team.new(id: 147), year: "2024")
      record2 = AttendanceRecord.new(team: Team.new(id: 147), year: "2024")

      assert_equal record1, record2
    end

    def test_inequality_different_team
      record1 = AttendanceRecord.new(team: Team.new(id: 147), year: "2024")
      record2 = AttendanceRecord.new(team: Team.new(id: 121), year: "2024")

      refute_equal record1, record2
    end

    def test_inequality_different_year
      record1 = AttendanceRecord.new(team: Team.new(id: 147), year: "2024")
      record2 = AttendanceRecord.new(team: Team.new(id: 147), year: "2023")

      refute_equal record1, record2
    end
  end
end
