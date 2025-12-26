require_relative "../test_helper"

module MLB
  class SportsTest < Minitest::Test
    cover Sports

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports")
        .to_return(body: '{"sports":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports"
      assert_equal 1, sport.id
    end

    def test_self_find
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/11")
        .to_return(body: '{"sports":[{"id":13,"sortOrder":3},{"id":11,"sortOrder":1},{"id":12,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/11"
      assert_equal 11, sport.id
      assert_equal 1, sport.sort_order
    end

    def test_self_find_with_sport_id
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/11")
        .to_return(body: '{"sports":[{"id":13,"sortOrder":3},{"id":11,"sortOrder":1},{"id":12,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/11"
      assert_equal 11, sport.id
      assert_equal 1, sport.sort_order
    end

    def test_self_find_with_nil_sort_order
      # First element has sortOrder 1, second has nil sortOrder
      # With || 0: [1, 0] - 0 < 1, min_by returns second (nil record, id 10)
      # With || 1: [1, 1] - tie, min_by returns first (sortOrder=1 record, id 11)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/10")
        .to_return(body: '{"sports":[{"id":11,"sortOrder":1},{"id":10}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(10)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/10"
      # With || 0: 0 < 1, returns second (id 10 with nil sortOrder)
      assert_equal 10, sport.id
      assert_nil sport.sort_order
    end

    def test_self_find_with_nil_and_zero_sort_order
      # First element has sortOrder 0, second has nil sortOrder
      # With || 0: [0, 0] - tie, min_by returns first (sortOrder=0 record, id 11)
      # With || -1: [0, -1] - -1 < 0, min_by returns second (nil record, id 10)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/11")
        .to_return(body: '{"sports":[{"id":11,"sortOrder":0},{"id":10}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/11"
      # With || 0: tie returns first (id 11 with sortOrder 0)
      assert_equal 11, sport.id
      assert_equal 0, sport.sort_order
    end
  end
end
