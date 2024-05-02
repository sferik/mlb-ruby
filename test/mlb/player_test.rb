require_relative "../test_helper"
require_relative "../../lib/mlb/player"

module MLB
  class PlayerTest < Minitest::Test
    cover Player

    def test_team
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season=#{Time.now.year}&sport_code='mlb'")
        .to_return(body: '{"team_all_season":{"queryResults":{"row":[{"team_id":"144"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      team = Player.new(team_id: 144).team

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season=#{Time.now.year}&sport_code='mlb'"
      assert_equal "144", team.team_id
    end
  end
end
