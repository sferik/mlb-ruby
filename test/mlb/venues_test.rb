require_relative "../test_helper"

module MLB
  class VenuesTest < Minitest::Test
    cover Venues

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues?season=2024&sportId=1")
        .to_return(body: '{"venues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues?season=2024&sportId=1"
      assert_equal 1, venue.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues?season=2024&sportId=1")
        .to_return(body: '{"venues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.all(sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues?season=2024&sportId=1"
      assert_equal 1, venue.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1")
        .to_return(body: '{"venues":[{"id":1},{"id":2}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(Venue.new(id: 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1"
      assert_equal 1, venue.id
    end

    def test_self_find_with_venue_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1")
        .to_return(body: '{"venues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1"
      assert_equal 1, venue.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1")
        .to_return(body: '{"venues":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(Venue.new(id: 1), sport: 1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/1?season=2024&sportId=1"
      assert_equal 1, venue.id
    end
  end
end
