require_relative "../test_helper"

module MLB
  class PitchTypeTest < Minitest::Test
    cover PitchType

    def test_objects_with_same_code_are_equal
      pitch_type1 = PitchType.new(code: "FF")
      pitch_type2 = PitchType.new(code: "FF")

      assert_equal pitch_type1, pitch_type2
    end

    def test_to_s_returns_code_and_description
      pitch_type = PitchType.new(code: "SL", description: "Slider")

      assert_equal "SL (Slider)", pitch_type.to_s
    end
  end
end
