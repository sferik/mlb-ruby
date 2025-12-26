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

    def test_comparison_with_nil_sort_order_places_nil_at_end
      with_order = League.new(sort_order: 1)
      without_order = League.new(sort_order: nil)

      assert_equal(-1, with_order <=> without_order)
      assert_equal(1, without_order <=> with_order)
    end

    def test_comparison_with_both_nil_sort_orders
      league1 = League.new(sort_order: nil)
      league2 = League.new(sort_order: nil)

      assert_equal(0, league1 <=> league2)
    end

    def test_comparison_with_non_league_returns_nil
      assert_nil(League.new(sort_order: 1) <=> "not a league")
    end

    def test_comparison_works_with_league_subclass
      subclass = Class.new(League)

      assert_equal(1, League.new(sort_order: 2) <=> subclass.new(sort_order: 1))
    end

    def test_objects_with_same_id_are_equal
      assert_equal League.new(id: 0), League.new(id: 0)
    end

    def test_active_predicate
      assert_predicate League.new(active: true), :active?
      refute_predicate League.new(active: false), :active?
      assert_nil League.new(active: nil).active?
    end

    def test_wildcard_predicate
      assert_predicate League.new(has_wildcard: true), :wildcard?
      refute_predicate League.new(has_wildcard: false), :wildcard?
      assert_nil League.new(has_wildcard: nil).wildcard?
    end

    def test_split_season_predicate
      assert_predicate League.new(has_split_season: true), :split_season?
      refute_predicate League.new(has_split_season: false), :split_season?
      assert_nil League.new(has_split_season: nil).split_season?
    end

    def test_playoff_points_predicate
      assert_predicate League.new(has_playoff_points: true), :playoff_points?
      refute_predicate League.new(has_playoff_points: false), :playoff_points?
      assert_nil League.new(has_playoff_points: nil).playoff_points?
    end

    def test_conferences_predicate
      assert_predicate League.new(conferences_in_use: true), :conferences?
      refute_predicate League.new(conferences_in_use: false), :conferences?
      assert_nil League.new(conferences_in_use: nil).conferences?
    end

    def test_divisions_predicate
      assert_predicate League.new(divisions_in_use: true), :divisions?
      refute_predicate League.new(divisions_in_use: false), :divisions?
      assert_nil League.new(divisions_in_use: nil).divisions?
    end

    def test_preseason_predicate
      assert_predicate League.new(season_state: "preseason"), :preseason?
      refute_predicate League.new(season_state: "inseason"), :preseason?
    end

    def test_in_season_predicate
      assert_predicate League.new(season_state: "inseason"), :in_season?
      refute_predicate League.new(season_state: "preseason"), :in_season?
    end

    def test_postseason_predicate
      assert_predicate League.new(season_state: "postseason"), :postseason?
      refute_predicate League.new(season_state: "inseason"), :postseason?
    end

    def test_offseason_predicate
      assert_predicate League.new(season_state: "offseason"), :offseason?
      refute_predicate League.new(season_state: "inseason"), :offseason?
    end
  end
end
