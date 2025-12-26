require_relative "../test_helper"

module MLB
  class GameStatusTest < Minitest::Test
    cover GameStatus

    def test_objects_with_same_status_code_are_equal
      game_status1 = GameStatus.new(status_code: "F")
      game_status2 = GameStatus.new(status_code: "F")

      assert_equal game_status1, game_status2
    end
  end
end
