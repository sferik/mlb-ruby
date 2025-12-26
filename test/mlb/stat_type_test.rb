require_relative "../test_helper"

module MLB
  class StatTypeTest < Minitest::Test
    cover StatType

    def test_objects_with_same_display_name_are_equal
      stat_type1 = StatType.new(display_name: "season")
      stat_type2 = StatType.new(display_name: "season")

      assert_equal stat_type1, stat_type2
    end
  end
end
