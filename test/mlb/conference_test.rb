require_relative "../test_helper"

module MLB
  class ConferenceTest < Minitest::Test
    cover Conference

    def test_objects_with_same_id_are_equal
      conference0 = Conference.new(id: 0)
      conference1 = Conference.new(id: 0)

      assert_equal conference0, conference1
    end

    def test_wildcard_returns_true_when_has_wildcard_is_true
      conference = Conference.new(has_wildcard: true)

      assert_predicate conference, :wildcard?
    end

    def test_wildcard_returns_false_when_has_wildcard_is_false
      conference = Conference.new(has_wildcard: false)

      refute_predicate conference, :wildcard?
    end

    def test_wildcard_returns_nil_when_has_wildcard_is_nil
      conference = Conference.new(has_wildcard: nil)

      assert_nil conference.wildcard?
    end
  end
end
