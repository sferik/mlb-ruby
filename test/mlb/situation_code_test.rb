require_relative "../test_helper"

module MLB
  class SituationCodeTest < Minitest::Test
    cover SituationCode

    def test_objects_with_same_code_are_equal
      situation_code1 = SituationCode.new(code: "h")
      situation_code2 = SituationCode.new(code: "h")

      assert_equal situation_code1, situation_code2
    end
  end
end
