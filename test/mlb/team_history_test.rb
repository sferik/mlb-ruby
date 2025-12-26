require_relative "../test_helper"

module MLB
  class TeamHistoryTest < Minitest::Test
    cover TeamHistory

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/history?teamIds=147")
        .to_return(body: team_history_json, headers: json_headers)
      teams = TeamHistory.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/history?teamIds=147"
      assert_equal 2, teams.size
      assert_equal 147, teams.first.id
      assert_equal "New York Yankees", teams.first.name
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/history?teamIds=147")
        .to_return(body: team_history_json, headers: json_headers)
      team = Team.new(id: 147)
      teams = TeamHistory.find(team:)

      assert_equal 2, teams.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def team_history_json
      '{"copyright":"Copyright","teams":[' \
        '{"id":147,"name":"New York Yankees","season":2009,"abbreviation":"NYY"},' \
        '{"id":147,"name":"New York Highlanders","season":1903,"abbreviation":"NYH"}]}'
    end
  end
end
