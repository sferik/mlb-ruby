require_relative "../test_helper"

module MLB
  class GameStatusesTest < Minitest::Test
    cover GameStatuses

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/gameStatus")
        .to_return(body: '[{"abstractGameState":"Final","codedGameState":"F",' \
                         '"detailedState":"Final","statusCode":"F","abstractGameCode":"F"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      game_status = GameStatuses.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/gameStatus"
      assert_equal "F", game_status.status_code
      assert_equal "Final", game_status.abstract_game_state
    end
  end
end
