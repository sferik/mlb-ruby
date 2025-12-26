require_relative "../test_helper"

module MLB
  class AwardTest < Minitest::Test
    cover Award

    def test_roster
      stub_request(:get, "https://statsapi.mlb.com/api/v1/awards/MLBHOF/recipients?season=#{Time.now.year}")
        .to_return(body: '{"awards":[{"id":"MLBHOF","player":{"id":144}}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      award = Award.new(id: "MLBHOF")
      player = award.recipients.first.player

      assert_requested :get, "https://statsapi.mlb.com/api/v1/awards/MLBHOF/recipients?season=#{Time.now.year}"
      assert_equal 144, player.id
    end

    def test_sorts_by_sort_order
      award0 = Award.new(sort_order: 0)
      award1 = Award.new(sort_order: 1)
      award2 = Award.new(sort_order: 2)

      assert award1.between?(award0, award2)
      assert_equal(1, award1 <=> award0)
      assert_equal(-1, award1 <=> award2)
    end

    def test_comparison_with_nil_sort_order_places_nil_at_end
      award_with_order = Award.new(sort_order: 1)
      award_without_order = Award.new(sort_order: nil)

      assert_equal(-1, award_with_order <=> award_without_order)
      assert_equal(1, award_without_order <=> award_with_order)
    end

    def test_comparison_with_both_nil_sort_orders
      award1 = Award.new(sort_order: nil)
      award2 = Award.new(sort_order: nil)

      assert_equal(0, award1 <=> award2)
    end

    def test_comparison_with_non_award_returns_nil
      award = Award.new(sort_order: 1)

      assert_nil(award <=> "not an award")
    end

    def test_comparison_works_with_award_subclass
      subclass = Class.new(Award)
      award = Award.new(sort_order: 2)
      subclass_award = subclass.new(sort_order: 1)

      assert_equal(1, award <=> subclass_award)
    end

    def test_objects_with_same_id_are_equal
      award0 = Award.new(id: 0)
      award1 = Award.new(id: 0)

      assert_equal award0, award1
    end
  end
end
