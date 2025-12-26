require_relative "../test_helper"

module MLB
  class SeasonsTest < Minitest::Test
    cover Seasons

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2025},{"seasonId":2024}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons?sportId=11")
        .to_return(body: '{"seasons":[{"seasonId":2025},{"seasonId":2024}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.all(sport: 11).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons?sportId=11"
      assert_equal 2024, season.id
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons?sportId=11")
        .to_return(body: '{"seasons":[{"seasonId":2025},{"seasonId":2024}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.all(sport: Sport.new(id: 11)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons?sportId=11"
      assert_equal 2024, season.id
    end

    def test_self_find
      # Middle element has lowest id - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2026},{"seasonId":2024},{"seasonId":2025}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(Season.new(id: 2024))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_find_with_season_id
      # Middle element has lowest id - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2026},{"seasonId":2024},{"seasonId":2025}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_find_with_nil_id
      # First element has id 1, second has nil id
      # With || 0: [1, 0] - 0 < 1, min_by returns second (nil record)
      # With || 1: [1, 1] - tie, min_by returns first (id=1 record)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/0?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":1},{}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(0)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/0?sportId=1"
      # With || 0: 0 < 1, returns second (nil id)
      assert_nil season.id
    end

    def test_self_find_with_nil_and_zero_id
      # First element has id 0, second has nil id
      # With || 0: [0, 0] - tie, min_by returns first (id=0 record)
      # With || -1: [0, -1] - -1 < 0, min_by returns second (nil record)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/0?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":0},{}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(0)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/0?sportId=1"
      # With || 0: tie returns first (id 0)
      assert_equal 0, season.id
    end

    def test_self_find_with_sport_id
      # Middle element has lowest id - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=11")
        .to_return(body: '{"seasons":[{"seasonId":2026},{"seasonId":2024},{"seasonId":2025}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(Season.new(id: 2024), sport: 11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=11"
      assert_equal 2024, season.id
    end

    def test_self_find_with_sport_object
      # Middle element has lowest id - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=11")
        .to_return(body: '{"seasons":[{"seasonId":2026},{"seasonId":2024},{"seasonId":2025}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(2024, sport: Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=11"
      assert_equal 2024, season.id
    end
  end
end
