require_relative "../test_helper"

module MLB
  class PositionTest < Minitest::Test
    cover Position

    def test_objects_with_same_code_are_equal
      position0 = Position.new(code: 0)
      position1 = Position.new(code: 0)

      assert_equal position0, position1
    end

    def test_pitcher?
      pitcher = Position.new(type: "Pitcher")

      assert_predicate pitcher, :pitcher?
      refute_predicate pitcher, :catcher?
      refute_predicate pitcher, :infielder?
      refute_predicate pitcher, :outfielder?

      catcher = Position.new(type: "Catcher")

      refute_predicate catcher, :pitcher?
    end

    def test_catcher?
      catcher = Position.new(type: "Catcher")

      assert_predicate catcher, :catcher?
      refute_predicate catcher, :pitcher?
      refute_predicate catcher, :infielder?
      refute_predicate catcher, :outfielder?

      pitcher = Position.new(type: "Pitcher")

      refute_predicate pitcher, :catcher?
    end

    def test_infielder?
      infielder = Position.new(type: "Infielder")

      assert_predicate infielder, :infielder?
      refute_predicate infielder, :pitcher?
      refute_predicate infielder, :catcher?
      refute_predicate infielder, :outfielder?

      pitcher = Position.new(type: "Pitcher")

      refute_predicate pitcher, :infielder?
    end

    def test_outfielder?
      outfielder = Position.new(type: "Outfielder")

      assert_predicate outfielder, :outfielder?
      refute_predicate outfielder, :pitcher?
      refute_predicate outfielder, :catcher?
      refute_predicate outfielder, :infielder?

      pitcher = Position.new(type: "Pitcher")

      refute_predicate pitcher, :outfielder?
    end
  end
end
