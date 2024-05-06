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
  end
end
