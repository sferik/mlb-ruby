require_relative "../test_helper"

module MLB
  class SeasonTest < Minitest::Test
    cover Season

    def test_sorts_by_sort_order
      season0 = Season.new(id: 2023)
      season1 = Season.new(id: 2024)
      season2 = Season.new(id: 2025)

      assert season1.between?(season0, season2)
      assert_equal(1, season1 <=> season0)
      assert_equal(-1, season1 <=> season2)
    end

    def test_objects_with_same_id_are_equal
      season0 = Season.new(id: 2024)
      season1 = Season.new(id: 2024)

      assert_equal season0, season1
    end
  end
end
