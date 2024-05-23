require_relative "../test_helper"

module MLB
  class HandednessTest < Minitest::Test
    cover Handedness

    def test_objects_with_same_code_are_equal
      handedness0 = Handedness.new(code: 0)
      handedness1 = Handedness.new(code: 0)

      assert_equal handedness0, handedness1
    end
  end
end
