require_relative "../test_helper"

module MLB
  class PlatformTest < Minitest::Test
    cover Platform

    def test_objects_with_same_platform_code_are_equal
      platform1 = Platform.new(platform_code: "web")
      platform2 = Platform.new(platform_code: "web")

      assert_equal platform1, platform2
    end
  end
end
