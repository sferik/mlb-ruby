require_relative "../test_helper"

module MLB
  class AttendanceTest < Minitest::Test
    cover Attendance

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/attendance?season=2024&teamId=147")
        .to_return(body: '{"copyright":"Copyright","records":[{"year":"2024",' \
                         '"team":{"id":147,"name":"New York Yankees"},' \
                         '"openingsTotal":160,"attendanceTotal":3309838}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      records = Attendance.find(team: 147, season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/attendance?season=2024&teamId=147"
      assert_equal 1, records.size
      assert_equal "2024", records.first.year
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/attendance?season=2024&teamId=147")
        .to_return(body: '{"copyright":"Copyright","records":[{"year":"2024",' \
                         '"team":{"id":147,"name":"New York Yankees"},' \
                         '"openingsTotal":160,"attendanceTotal":3309838}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Team.new(id: 147)
      records = Attendance.find(team:, season: 2024)

      assert_equal 1, records.size
      assert_equal 147, records.first.team.id
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/attendance?season=#{year}&teamId=147")
        .to_return(body: '{"copyright":"Copyright","records":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      records = Attendance.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/attendance?season=#{year}&teamId=147"
      assert_equal 0, records.size
    end
  end
end
