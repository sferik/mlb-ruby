require_relative "../test_helper"

module MLB
  class PostseasonSeriesTest < Minitest::Test
    cover PostseasonSeries

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=2024&sportId=1")
        .to_return(body: postseason_series_json, headers: json_headers)
      series = PostseasonSeries.all(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=2024&sportId=1"
      assert_equal 2, series.size
      assert_equal "W_1", series.first.series.id
      assert_equal 5, series.first.total_games
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=2024&sportId=1")
        .to_return(body: postseason_series_json, headers: json_headers)
      sport = Sport.new(id: 1)
      series = PostseasonSeries.all(season: 2024, sport:)

      assert_equal 2, series.size
    end

    def test_self_all_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=#{year}&sportId=1")
        .to_return(body: '{"series":[]}', headers: json_headers)
      series = PostseasonSeries.all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=#{year}&sportId=1"
      assert_equal 0, series.size
    end

    def test_series_games
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason/series?season=2024&sportId=1")
        .to_return(body: postseason_series_json, headers: json_headers)
      series = PostseasonSeries.all(season: 2024)

      assert_equal 775_300, series.first.games.first.game_pk
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def postseason_series_json
      '{"copyright":"Copyright","series":[' \
        '{"series":{"id":"W_1","sortNumber":1,"gameType":"W"},' \
        '"totalGames":5,"games":[{"gamePk":775300,"gameDate":"2024-10-26T00:08:00Z",' \
        '"status":{"detailedState":"Final"},"teams":{"away":{"team":{"id":147}},' \
        '"home":{"team":{"id":119}}}}]},{"series":{"id":"A_1","sortNumber":2,' \
        '"gameType":"L"},"totalGames":7,"games":[{"gamePk":775301,' \
        '"gameDate":"2024-10-20T00:08:00Z","status":{"detailedState":"Final"},' \
        '"teams":{"away":{"team":{"id":147}},"home":{"team":{"id":114}}}}]}]}'
    end
  end
end
