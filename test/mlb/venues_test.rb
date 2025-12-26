require_relative "../test_helper"

module MLB
  class VenuesTest < Minitest::Test
    cover Venues

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=1"
      assert_equal 15, venue.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.all(sport: 11).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=11"
      assert_equal 15, venue.id
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.all(sport: Sport.new(id: 11)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues?season=#{Time.now.year}&sportId=11"
      assert_equal 15, venue.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"venues":[{"id":15},{"id":16}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(Venue.new(id: 15))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=1"
      assert_equal 15, venue.id
    end

    def test_self_find_with_venue_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(15)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=1"
      assert_equal 15, venue.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(Venue.new(id: 15), sport: 11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=11"
      assert_equal 15, venue.id
    end

    def test_self_find_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"venues":[{"id":15}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      venue = Venues.find(15, sport: Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/venues/15?season=#{Time.now.year}&sportId=11"
      assert_equal 15, venue.id
    end
  end
end
