require_relative "../test_helper"

module MLB
  class TeamTest < Minitest::Test
    cover Team

    def test_roster
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024")
        .to_return(body: '{"roster":[{"parentTeamId":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Team.new(id: 144)
      roster_entry = team.roster.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=2024"
      assert_equal 144, roster_entry.team_id
    end
  end
end
