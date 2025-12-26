require_relative "../test_helper"

module MLB
  class SportPlayersTest < Minitest::Test
    cover SportPlayers

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=2024")
        .to_return(body: sport_players_json, headers: json_headers)
      players = SportPlayers.all(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=2024"
      assert_equal 2, players.size
      assert_equal 671_096, players.first.id
      assert_equal "Andrew Abbott", players.first.full_name
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=2024")
        .to_return(body: sport_players_json, headers: json_headers)
      sport = Sport.new(id: 1)
      players = SportPlayers.all(season: 2024, sport:)

      assert_equal 2, players.size
    end

    def test_self_all_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{year}")
        .to_return(body: '{"people":[]}', headers: json_headers)
      players = SportPlayers.all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{year}"
      assert_equal 0, players.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def sport_players_json
      '{"copyright":"Copyright","people":[' \
        '{"id":671096,"fullName":"Andrew Abbott",' \
        '"primaryPosition":{"code":"1","name":"Pitcher"}},' \
        '{"id":682928,"fullName":"CJ Abrams",' \
        '"primaryPosition":{"code":"6","name":"Shortstop"}}]}'
    end
  end
end
