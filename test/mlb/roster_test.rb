require_relative "../test_helper"

module MLB
  class RosterTest < Minitest::Test
    cover Roster

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1")
        .to_return(body: '{"roster":[{"parentTeamId":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      roster = Roster.find(team: Team.new(id: 144)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1"
      assert_equal 144, roster.team_id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1")
        .to_return(body: '{"roster":[{"parentTeamId":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      roster = Roster.find(team: 144, sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1"
      assert_equal 144, roster.team_id
    end

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1")
        .to_return(body: '{"roster":[{"parentTeamId":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      roster = Roster.find(team: 144).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024&sportId=1"
      assert_equal 144, roster.team_id
    end
  end
end
