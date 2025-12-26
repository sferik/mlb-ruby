require_relative "../test_helper"

module MLB
  class EventTypeTest < Minitest::Test
    cover EventType

    def test_plate_appearance_predicate
      event_type = EventType.new(plate_appearance: true)

      assert_predicate event_type, :plate_appearance?
    end

    def test_hit_predicate
      event_type = EventType.new(hit: true)

      assert_predicate event_type, :hit?
    end

    def test_base_running_event_predicate
      event_type = EventType.new(base_running_event: true)

      assert_predicate event_type, :base_running_event?
    end

    def test_objects_with_same_code_are_equal
      event_type1 = EventType.new(code: "single")
      event_type2 = EventType.new(code: "single")

      assert_equal event_type1, event_type2
    end
  end
end
