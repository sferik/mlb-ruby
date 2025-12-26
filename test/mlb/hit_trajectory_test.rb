require_relative "../test_helper"

module MLB
  class HitTrajectoryTest < Minitest::Test
    cover HitTrajectory

    def test_objects_with_same_code_are_equal
      hit_trajectory1 = HitTrajectory.new(code: "line_drive")
      hit_trajectory2 = HitTrajectory.new(code: "line_drive")

      assert_equal hit_trajectory1, hit_trajectory2
    end
  end
end
