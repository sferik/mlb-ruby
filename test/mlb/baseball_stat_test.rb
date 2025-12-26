require_relative "../test_helper"

module MLB
  class BaseballStatTest < Minitest::Test
    cover BaseballStat

    def test_counting_predicate
      stat = BaseballStat.new(is_counting: true)

      assert_predicate stat, :counting?
    end

    def test_counting_predicate_false
      stat = BaseballStat.new(is_counting: false)

      refute_predicate stat, :counting?
    end

    def test_objects_with_same_name_are_equal
      stat1 = BaseballStat.new(name: "homeRuns")
      stat2 = BaseballStat.new(name: "homeRuns")

      assert_equal stat1, stat2
    end
  end
end
