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
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2025},{"seasonId":2024}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.all(sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2025},{"seasonId":2024}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(Season.new(id: 2024))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_find_with_season_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2024}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1"
      assert_equal 2024, season.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1")
        .to_return(body: '{"seasons":[{"seasonId":2024}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      season = Seasons.find(Season.new(id: 2024), sport: 1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/seasons/2024?sportId=1"
      assert_equal 2024, season.id
    end
  end
end
