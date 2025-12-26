require_relative "../test_helper"

module MLB
  class GamePaceTest < Minitest::Test
    cover GamePace

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/gamePace?season=2024")
        .to_return(body: game_pace_json, headers: json_headers)
      stats = GamePace.find(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/gamePace?season=2024"
      assert_in_delta 16.63, stats.hits_per_9inn
      assert_in_delta 8.91, stats.runs_per_9inn
      assert_equal 2429, stats.total_games
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/gamePace?season=#{year}")
        .to_return(body: game_pace_json, headers: json_headers)
      stats = GamePace.find

      assert_requested :get, "https://statsapi.mlb.com/api/v1/gamePace?season=#{year}"
      assert_equal "02:38:44", stats.time_per_game
    end

    def test_self_find_returns_first_sport
      stub_request(:get, "https://statsapi.mlb.com/api/v1/gamePace?season=2024")
        .to_return(body: multi_sport_json, headers: json_headers)
      stats = GamePace.find(season: 2024)

      assert_equal 1, stats.sport.id
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def game_pace_json
      '{"copyright":"Copyright","sports":[{"hitsPer9Inn":16.63,"runsPer9Inn":8.91,' \
        '"pitchesPer9Inn":296.2,"hitsPerGame":16.39,"runsPerGame":8.79,' \
        '"pitchesPerGame":292.1,"totalGames":2429,"totalInningsPlayed":21626.5,' \
        '"totalHits":39823,"totalRuns":21343,"totalPitches":709511,' \
        '"timePerGame":"02:38:44","timePerPitch":"00:00:32","season":"2024",' \
        '"sport":{"id":1,"code":"mlb"}}]}'
    end

    def multi_sport_json
      '{"sports":[{"sport":{"id":1,"code":"mlb"},"totalGames":100},' \
        '{"sport":{"id":11,"code":"aaa"},"totalGames":50}]}'
    end
  end
end
