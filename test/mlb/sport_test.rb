require_relative "../test_helper"

module MLB
  class SportTest < Minitest::Test
    cover Sport

    def test_sorts_by_sort_order
      sport0 = Sport.new(sort_order: 0)
      sport1 = Sport.new(sort_order: 1)
      sport2 = Sport.new(sort_order: 2)

      assert sport1.between?(sport0, sport2)
      assert_equal(1, sport1 <=> sport0)
      assert_equal(-1, sport1 <=> sport2)
    end

    def test_comparison_with_nil_sort_order_places_nil_at_end
      with_order = Sport.new(sort_order: 1)
      without_order = Sport.new(sort_order: nil)

      assert_equal(-1, with_order <=> without_order)
      assert_equal(1, without_order <=> with_order)
    end

    def test_comparison_with_both_nil_sort_orders
      sport1 = Sport.new(sort_order: nil)
      sport2 = Sport.new(sort_order: nil)

      assert_equal(0, sport1 <=> sport2)
    end

    def test_comparison_with_non_sport_returns_nil
      sport = Sport.new(sort_order: 1)

      assert_nil(sport <=> "not a sport")
    end

    def test_comparison_works_with_sport_subclass
      subclass = Class.new(Sport)
      sport = Sport.new(sort_order: 2)
      subclass_sport = subclass.new(sort_order: 1)

      assert_equal(1, sport <=> subclass_sport)
    end

    def test_objects_with_same_id_are_equal
      sport0 = Sport.new(id: 0)
      sport1 = Sport.new(id: 0)

      assert_equal sport0, sport1
    end

    def test_active_returns_true_when_active_is_true
      sport = Sport.new(active: true)

      assert_predicate sport, :active?
    end

    def test_active_returns_false_when_active_is_false
      sport = Sport.new(active: false)

      refute_predicate sport, :active?
    end

    def test_active_returns_nil_when_active_is_nil
      sport = Sport.new(active: nil)

      assert_nil sport.active?
    end
  end
end
