require_relative "../test_helper"

module MLB
  class PlayersTest < Minitest::Test
    cover Players

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}")
        .to_return(body: '{"people":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      player = Players.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}"
      assert_equal 1, player.id
    end

    def test_self_all_with_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=1983")
        .to_return(body: '{"people":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      player = Players.all(season: 1983).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=1983"
      assert_equal 1, player.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}")
        .to_return(body: '{"people":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      player = Players.all(sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}"
      assert_equal 1, player.id
    end
  end
end
