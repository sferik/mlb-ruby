require_relative "../test_helper"

module MLB
  class RosterTypeTest < Minitest::Test
    cover RosterType

    def test_objects_with_same_parameter_are_equal
      roster_type1 = RosterType.new(parameter: "40Man")
      roster_type2 = RosterType.new(parameter: "40Man")

      assert_equal roster_type1, roster_type2
    end
  end
end
