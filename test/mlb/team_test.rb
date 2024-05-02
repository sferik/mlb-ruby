require_relative "../test_helper"

module MLB
  class TeamTest < Minitest::Test
    cover Team

    def test_self_all
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season='1983'&sort_order=name_asc&sport_code='mlb'")
        .to_return(body: '{"team_all_season":{"queryResults":{"row":[{"team_id":"144"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      team = Team.all(season: 1983).first

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season='1983'&sort_order=name_asc&sport_code='mlb'"
      assert_equal "144", team.team_id
    end

    def test_roster
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=144")
        .to_return(body: '{"roster_40":{"queryResults":{"row":[{"player_id":"660670"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      team = Team.new(team_id: 144)
      player = team.roster.first

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=144"
      assert_equal "660670", player.player_id
    end
  end
end
