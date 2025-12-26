require_relative "../test_helper"

module MLB
  class WindDirectionTest < Minitest::Test
    cover WindDirection

    def test_objects_with_same_code_are_equal
      wind_direction1 = WindDirection.new(code: "In From CF")
      wind_direction2 = WindDirection.new(code: "In From CF")

      assert_equal wind_direction1, wind_direction2
    end
  end
end
