require_relative "../test_helper"

module MLB
  class PitchCodeTest < Minitest::Test
    cover PitchCode

    def test_objects_with_same_code_are_equal
      pitch_code1 = PitchCode.new(code: "B")
      pitch_code2 = PitchCode.new(code: "B")

      assert_equal pitch_code1, pitch_code2
    end
  end
end
