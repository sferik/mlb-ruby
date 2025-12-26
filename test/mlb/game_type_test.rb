require_relative "../test_helper"

module MLB
  class GameTypeTest < Minitest::Test
    cover GameType

    def test_objects_with_same_id_are_equal
      game_type1 = GameType.new(id: "R")
      game_type2 = GameType.new(id: "R")

      assert_equal game_type1, game_type2
    end

    def test_to_s_returns_id_and_description
      game_type = GameType.new(id: "R", description: "Regular Season")

      assert_equal "R (Regular Season)", game_type.to_s
    end
  end
end
