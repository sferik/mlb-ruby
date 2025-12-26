require_relative "../test_helper"

module MLB
  class GameTypesTest < Minitest::Test
    cover GameTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/gameTypes")
        .to_return(body: '[{"id":"R","description":"Regular Season"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      game_type = GameTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/gameTypes"
      assert_equal "R", game_type.id
      assert_equal "Regular Season", game_type.description
    end
  end
end
