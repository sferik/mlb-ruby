require_relative "../test_helper"

module MLB
  class GameStatusTest < Minitest::Test
    cover GameStatus

    def test_objects_with_same_status_code_are_equal
      game_status1 = GameStatus.new(status_code: "F")
      game_status2 = GameStatus.new(status_code: "F")

      assert_equal game_status1, game_status2
    end

    def test_final?
      final_status = GameStatus.new(abstract_game_state: "Final")

      assert_predicate final_status, :final?
      refute_predicate final_status, :live?
      refute_predicate final_status, :preview?

      live_status = GameStatus.new(abstract_game_state: "Live")

      refute_predicate live_status, :final?
    end

    def test_live?
      live_status = GameStatus.new(abstract_game_state: "Live")

      assert_predicate live_status, :live?
      refute_predicate live_status, :final?
      refute_predicate live_status, :preview?

      final_status = GameStatus.new(abstract_game_state: "Final")

      refute_predicate final_status, :live?
    end

    def test_preview?
      preview_status = GameStatus.new(abstract_game_state: "Preview")

      assert_predicate preview_status, :preview?
      refute_predicate preview_status, :final?
      refute_predicate preview_status, :live?

      final_status = GameStatus.new(abstract_game_state: "Final")

      refute_predicate final_status, :preview?
    end
  end
end
