require_relative "../test_helper"

module MLB
  class StandingsTypesTest < Minitest::Test
    cover StandingsTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standingsTypes")
        .to_return(body: '[{"name":"regularSeason","description":"Regular Season Standings"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      standings_type = StandingsTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/standingsTypes"
      assert_equal "regularSeason", standings_type.name
      assert_equal "Regular Season Standings", standings_type.description
    end
  end
end
