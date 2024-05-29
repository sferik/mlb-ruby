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
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1")
        .to_return(body: '{"sports":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(Sport.new(id: 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1"
      assert_equal 1, sport.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1")
        .to_return(body: '{"sports":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sport = Sports.find(1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1"
      assert_equal 1, sport.id
    end
  end
end
