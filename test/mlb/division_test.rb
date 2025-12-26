require_relative "../test_helper"

module MLB
  class DivisionTest < Minitest::Test
    cover Division

    def test_sorts_by_sort_order
      division0 = Division.new(sort_order: 0)
      division1 = Division.new(sort_order: 1)
      division2 = Division.new(sort_order: 2)

      assert division1.between?(division0, division2)
      assert_equal(1, division1 <=> division0)
      assert_equal(-1, division1 <=> division2)
    end

    def test_comparison_with_nil_sort_order_places_nil_at_end
      with_order = Division.new(sort_order: 1)
      without_order = Division.new(sort_order: nil)

      assert_equal(-1, with_order <=> without_order)
      assert_equal(1, without_order <=> with_order)
    end

    def test_comparison_with_both_nil_sort_orders
      division1 = Division.new(sort_order: nil)
      division2 = Division.new(sort_order: nil)

      assert_equal(0, division1 <=> division2)
    end

    def test_comparison_with_non_division_returns_nil
      division = Division.new(sort_order: 1)

      assert_nil(division <=> "not a division")
    end

    def test_comparison_works_with_division_subclass
      subclass = Class.new(Division)
      division = Division.new(sort_order: 2)
      subclass_division = subclass.new(sort_order: 1)

      assert_equal(1, division <=> subclass_division)
    end

    def test_objects_with_same_id_are_equal
      division0 = Division.new(id: 0)
      division1 = Division.new(id: 0)

      assert_equal division0, division1
    end

    def test_active_returns_true_when_active_is_true
      division = Division.new(active: true)

      assert_predicate division, :active?
    end

    def test_active_returns_false_when_active_is_false
      division = Division.new(active: false)

      refute_predicate division, :active?
    end

    def test_active_returns_nil_when_active_is_nil
      division = Division.new(active: nil)

      assert_nil division.active?
    end

    def test_wildcard_returns_true_when_has_wildcard_is_true
      division = Division.new(has_wildcard: true)

      assert_predicate division, :wildcard?
    end

    def test_wildcard_returns_false_when_has_wildcard_is_false
      division = Division.new(has_wildcard: false)

      refute_predicate division, :wildcard?
    end

    def test_wildcard_returns_nil_when_has_wildcard_is_nil
      division = Division.new(has_wildcard: nil)

      assert_nil division.wildcard?
    end
  end
end
