require_relative "../test_helper"

module MLB
  class StatGroupTest < Minitest::Test
    cover StatGroup

    def test_objects_with_same_display_name_are_equal
      stat_group1 = StatGroup.new(display_name: "hitting")
      stat_group2 = StatGroup.new(display_name: "hitting")

      assert_equal stat_group1, stat_group2
    end
  end
end
