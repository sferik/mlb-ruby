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
  end
end
