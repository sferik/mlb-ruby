require_relative "../test_helper"

module MLB
  class LeagueLeaderTypesTest < Minitest::Test
    cover LeagueLeaderTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagueLeaderTypes")
        .to_return(body: '[{"displayName":"homeRuns"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      leader_type = LeagueLeaderTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagueLeaderTypes"
      assert_equal "homeRuns", leader_type.display_name
    end
  end
end
