require_relative "../test_helper"

module MLB
  class CoachesTest < Minitest::Test
    cover Coaches

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/coaches?season=2024")
        .to_return(body: coaches_json, headers: json_headers)
      coaches = Coaches.find(team: 147, season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/coaches?season=2024"
      assert_equal 2, coaches.size
      assert_equal "Manager", coaches.first.job
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/coaches?season=2024")
        .to_return(body: coaches_json, headers: json_headers)
      team = Team.new(id: 147)
      coaches = Coaches.find(team:, season: 2024)

      assert_equal 2, coaches.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/coaches?season=#{year}")
        .to_return(body: '{"roster":[]}', headers: json_headers)
      coaches = Coaches.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/coaches?season=#{year}"
      assert_equal 0, coaches.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def coaches_json
      '{"copyright":"Copyright","roster":[' \
        '{"person":{"id":111213,"fullName":"Aaron Boone"},' \
        '"jerseyNumber":"17","job":"Manager","jobId":"MNGR","title":"Manager"},' \
        '{"person":{"id":110385,"fullName":"Brad Ausmus"},' \
        '"jerseyNumber":"65","job":"Bench Coach","jobId":"COAB","title":"Bench Coach"}]}'
    end
  end
end
