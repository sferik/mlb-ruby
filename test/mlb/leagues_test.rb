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
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues?sportId=1")
        .to_return(body: '{"leagues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.all(sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues?sportId=1"
      assert_equal 1, league.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1")
        .to_return(body: '{"leagues":[{"id":1},{"id":2}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(League.new(id: 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1"
      assert_equal 1, league.id
    end

    def test_self_find_with_league_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1")
        .to_return(body: '{"leagues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1"
      assert_equal 1, league.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1")
        .to_return(body: '{"leagues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      league = Leagues.find(1, sport: 1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/leagues/1?sportId=1"
      assert_equal 1, league.id
    end
  end
end
