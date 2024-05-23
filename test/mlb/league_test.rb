require_relative "../test_helper"

module MLB
  class LeagueTest < Minitest::Test
    cover League

    def test_sorts_by_sort_order
      league0 = League.new(sort_order: 0)
      league1 = League.new(sort_order: 1)
      league2 = League.new(sort_order: 2)

      assert league1.between?(league0, league2)
      assert_equal(1, league1 <=> league0)
      assert_equal(-1, league1 <=> league2)
    end

    def test_objects_with_same_id_are_equal
      league0 = League.new(id: 0)
      league1 = League.new(id: 0)

      assert_equal league0, league1
    end
  end
end
