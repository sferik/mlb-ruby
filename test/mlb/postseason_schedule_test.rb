require_relative "../test_helper"

module MLB
  class PostseasonScheduleTest < Minitest::Test
    cover PostseasonSchedule

    def test_self_games
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason?season=2024")
        .to_return(body: postseason_json, headers: json_headers)
      games = PostseasonSchedule.games(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/postseason?season=2024"
      assert_equal 2, games.size
      assert_equal 775_345, games.first.game_pk
    end

    def test_self_games_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/postseason?season=#{year}")
        .to_return(body: '{"totalGames":0,"dates":[]}', headers: json_headers)
      games = PostseasonSchedule.games

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/postseason?season=#{year}"
      assert_equal 0, games.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def postseason_json
      '{"copyright":"Copyright","totalGames":2,"dates":[' \
        '{"date":"2024-10-01","totalGames":2,"games":[' \
        '{"gamePk":775345,"gameType":"F","season":"2024",' \
        '"seriesDescription":"Wild Card"},' \
        '{"gamePk":775343,"gameType":"F","season":"2024",' \
        '"seriesDescription":"Wild Card"}]}]}'
    end
  end
end
