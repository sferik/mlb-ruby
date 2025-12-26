require_relative "../test_helper"

module MLB
  class SeasonTest < Minitest::Test
    cover Season

    def test_sorts_by_id
      season0 = Season.new(id: 2023)
      season1 = Season.new(id: 2024)
      season2 = Season.new(id: 2025)

      assert season1.between?(season0, season2)
      assert_equal(1, season1 <=> season0)
      assert_equal(-1, season1 <=> season2)
    end

    def test_comparison_with_nil_id_places_nil_at_end
      with_id = Season.new(id: 2024)
      without_id = Season.new(id: nil)

      assert_equal(-1, with_id <=> without_id)
      assert_equal(1, without_id <=> with_id)
    end

    def test_comparison_with_both_nil_ids
      season1 = Season.new(id: nil)
      season2 = Season.new(id: nil)

      assert_equal(0, season1 <=> season2)
    end

    def test_comparison_with_non_season_returns_nil
      season = Season.new(id: 2024)

      assert_nil(season <=> "not a season")
    end

    def test_comparison_works_with_season_subclass
      subclass = Class.new(Season)
      season = Season.new(id: 2025)
      subclass_season = subclass.new(id: 2024)

      assert_equal(1, season <=> subclass_season)
    end

    def test_objects_with_same_id_are_equal
      season0 = Season.new(id: 2024)
      season1 = Season.new(id: 2024)

      assert_equal season0, season1
    end
  end
end
