require_relative "../test_helper"

module MLB
  class LeaguesTest < Minitest::Test
    cover Leagues

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues?sportId=1")
        .to_return(body: '{"leagues":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues?sportId=1"
      assert_equal 1, league.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues?sportId=11")
        .to_return(body: '{"leagues":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.all(sport: 11).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues?sportId=11"
      assert_equal 1, league.id
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues?sportId=11")
        .to_return(body: '{"leagues":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.all(sport: Sport.new(id: 11)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues?sportId=11"
      assert_equal 1, league.id
    end

    def test_self_find
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1")
        .to_return(body: '{"leagues":[{"id":105,"sortOrder":3},{"id":103,"sortOrder":1},{"id":104,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(League.new(id: 103))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1"
      assert_equal 103, league.id
      assert_equal 1, league.sort_order
    end

    def test_self_find_with_league_id
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1")
        .to_return(body: '{"leagues":[{"id":105,"sortOrder":3},{"id":103,"sortOrder":1},{"id":104,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(103)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1"
      assert_equal 103, league.id
      assert_equal 1, league.sort_order
    end

    def test_self_find_with_nil_sort_order
      # First element has sortOrder 1, second has nil sortOrder
      # With || 0: [1, 0] - 0 < 1, min_by returns second (nil record, id 102)
      # With || 1: [1, 1] - tie, min_by returns first (sortOrder=1 record, id 103)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/102?sportId=1")
        .to_return(body: '{"leagues":[{"id":103,"sortOrder":1},{"id":102}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(102)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/102?sportId=1"
      # With || 0: 0 < 1, returns second (id 102 with nil sortOrder)
      assert_equal 102, league.id
      assert_nil league.sort_order
    end

    def test_self_find_with_nil_and_zero_sort_order
      # First element has sortOrder 0, second has nil sortOrder
      # With || 0: [0, 0] - tie, min_by returns first (sortOrder=0 record, id 103)
      # With || -1: [0, -1] - -1 < 0, min_by returns second (nil record, id 102)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1")
        .to_return(body: '{"leagues":[{"id":103,"sortOrder":0},{"id":102}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(103)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=1"
      # With || 0: tie returns first (id 103 with sortOrder 0)
      assert_equal 103, league.id
      assert_equal 0, league.sort_order
    end

    def test_self_find_with_sport_id
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=11")
        .to_return(body: '{"leagues":[{"id":105,"sortOrder":3},{"id":103,"sortOrder":1},{"id":104,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(103, sport: 11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=11"
      assert_equal 103, league.id
      assert_equal 1, league.sort_order
    end

    def test_self_find_with_sport_object
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=11")
        .to_return(body: '{"leagues":[{"id":105,"sortOrder":3},{"id":103,"sortOrder":1},{"id":104,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(103, sport: Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/103?sportId=11"
      assert_equal 103, league.id
      assert_equal 1, league.sort_order
    end
  end
end
