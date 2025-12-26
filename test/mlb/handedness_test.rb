require_relative "../test_helper"

module MLB
  class HandednessTest < Minitest::Test
    cover Handedness

    def test_objects_with_same_code_are_equal
      handedness0 = Handedness.new(code: 0)
      handedness1 = Handedness.new(code: 0)

      assert_equal handedness0, handedness1
    end

    def test_left?
      left_handed = Handedness.new(code: "L")

      assert_predicate left_handed, :left?
      refute_predicate left_handed, :right?
      refute_predicate left_handed, :switch?

      right_handed = Handedness.new(code: "R")

      refute_predicate right_handed, :left?
    end

    def test_right?
      right_handed = Handedness.new(code: "R")

      assert_predicate right_handed, :right?
      refute_predicate right_handed, :left?
      refute_predicate right_handed, :switch?

      left_handed = Handedness.new(code: "L")

      refute_predicate left_handed, :right?
    end

    def test_switch?
      switch_hitter = Handedness.new(code: "S")

      assert_predicate switch_hitter, :switch?
      refute_predicate switch_hitter, :left?
      refute_predicate switch_hitter, :right?

      left_handed = Handedness.new(code: "L")

      refute_predicate left_handed, :switch?
    end
  end
end
