require_relative "../test_helper"

module MLB
  class ScheduleEventTypeTest < Minitest::Test
    cover ScheduleEventType

    def test_objects_with_same_code_are_equal
      schedule_event_type1 = ScheduleEventType.new(code: "P")
      schedule_event_type2 = ScheduleEventType.new(code: "P")

      assert_equal schedule_event_type1, schedule_event_type2
    end
  end
end
