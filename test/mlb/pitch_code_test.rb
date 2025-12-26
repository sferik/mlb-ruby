require_relative "../test_helper"

module MLB
  class PitchCodeTest < Minitest::Test
    cover PitchCode

    def test_objects_with_same_code_are_equal
      pitch_code1 = PitchCode.new(code: "B")
      pitch_code2 = PitchCode.new(code: "B")

      assert_equal pitch_code1, pitch_code2
    end

    def test_swing_predicate
      assert_predicate PitchCode.new(swing_status: true), :swing?
      refute_predicate PitchCode.new(swing_status: false), :swing?
      assert_nil PitchCode.new(swing_status: nil).swing?
    end

    def test_strike_predicate
      assert_predicate PitchCode.new(strike_status: true), :strike?
      refute_predicate PitchCode.new(strike_status: false), :strike?
      assert_nil PitchCode.new(strike_status: nil).strike?
    end

    def test_ball_predicate
      assert_predicate PitchCode.new(ball_status: true), :ball?
      refute_predicate PitchCode.new(ball_status: false), :ball?
      assert_nil PitchCode.new(ball_status: nil).ball?
    end
  end
end
