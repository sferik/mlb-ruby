require_relative "../test_helper"

module MLB
  class ConferenceTest < Minitest::Test
    cover Conference
    def test_objects_with_same_id_are_equal
      conference0 = Conference.new(id: 0)
      conference1 = Conference.new(id: 0)

      assert_equal conference0, conference1
    end
  end
end
