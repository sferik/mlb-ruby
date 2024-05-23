require_relative "../test_helper"

module MLB
  class PlayerTest < Minitest::Test
    cover Player

    def test_objects_with_same_id_are_equal
      player0 = Player.new(id: 0)
      player1 = Player.new(id: 0)

      assert_equal player0, player1
    end
  end
end
