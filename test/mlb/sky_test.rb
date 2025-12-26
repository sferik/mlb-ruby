require_relative "../test_helper"

module MLB
  class SkyTest < Minitest::Test
    cover Sky

    def test_objects_with_same_code_are_equal
      sky1 = Sky.new(code: "Clear")
      sky2 = Sky.new(code: "Clear")

      assert_equal sky1, sky2
    end
  end
end
