require_relative "../test_helper"

module MLB
  class TeamTest < Minitest::Test
    cover Team

    def test_roster
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=#{Time.now.year}")
        .to_return(body: '{"roster":[{"parentTeamId":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Team.new(id: 144)
      roster_entry = team.roster.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144/roster?season=#{Time.now.year}"
      assert_equal 144, roster_entry.team_id
    end

    def test_objects_with_same_id_are_equal
      team0 = Team.new(id: 0)
      team1 = Team.new(id: 0)

      assert_equal team0, team1
    end
  end
end
