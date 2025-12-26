require_relative "../test_helper"

module MLB
  class TiedGamesTest < Minitest::Test
    cover TiedGames

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/games/tied?season=2024")
        .to_return(body: tied_games_json, headers: json_headers)
      games = TiedGames.all(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/games/tied?season=2024"
      assert_equal 1, games.size
      assert_equal 745_571, games.first.game_pk
    end

    def test_self_all_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule/games/tied?season=#{year}")
        .to_return(body: '{"dates":[]}', headers: json_headers)
      games = TiedGames.all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule/games/tied?season=#{year}"
      assert_equal 0, games.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def tied_games_json
      '{"copyright":"Copyright","dates":[' \
        '{"date":"2024-06-09","games":[' \
        '{"gamePk":745571,"gameDate":"2024-06-09T18:10:00Z",' \
        '"status":{"detailedState":"Final"},' \
        '"teams":{"away":{"team":{"id":121,"name":"New York Mets"}},' \
        '"home":{"team":{"id":143,"name":"Philadelphia Phillies"}}}}]}]}'
    end
  end
end
