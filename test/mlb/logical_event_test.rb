require_relative "../test_helper"

module MLB
  class LogicalEventTest < Minitest::Test
    cover LogicalEvent

    def test_objects_with_same_code_are_equal
      logical_event1 = LogicalEvent.new(code: "countChange")
      logical_event2 = LogicalEvent.new(code: "countChange")

      assert_equal logical_event1, logical_event2
    end
  end
end
