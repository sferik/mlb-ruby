require_relative "../test_helper"

module MLB
  class AffiliatesTest < Minitest::Test
    cover Affiliates

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/affiliates?season=2024&teamIds=147")
        .to_return(body: affiliates_json, headers: json_headers)
      teams = Affiliates.find(team: 147, season: 2024)

      assert_requested :get,
        "https://statsapi.mlb.com/api/v1/teams/affiliates?season=2024&teamIds=147"
      assert_equal 2, teams.size
      assert_equal 147, teams.first.id
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/affiliates?season=2024&teamIds=147")
        .to_return(body: affiliates_json, headers: json_headers)
      team = Team.new(id: 147)
      teams = Affiliates.find(team:, season: 2024)

      assert_equal 2, teams.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/affiliates?season=#{year}&teamIds=147")
        .to_return(body: '{"teams":[]}', headers: json_headers)
      teams = Affiliates.find(team: 147)

      assert_equal 0, teams.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def affiliates_json
      '{"copyright":"Copyright","teams":[' \
        '{"id":147,"name":"New York Yankees"},' \
        '{"id":386,"name":"New York Yankees Prospects"}]}'
    end
  end
end
