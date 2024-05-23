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

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people?personIds=493603")
        .to_return(body: '{"people":[{"id":493603},{"id":621438}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      player = Players.find(Player.new(id: 493_603))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people?personIds=493603"
      assert_equal 493_603, player.id
    end

    def test_self_find_with_player_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people?personIds=493603")
        .to_return(body: '{"people":[{"id":493603},{"id":621438}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      player = Players.find(493_603)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people?personIds=493603"
      assert_equal 493_603, player.id
    end

    def test_self_find_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people?personIds=493603,621438")
        .to_return(body: '{"people":[{"id":493603},{"id":621438}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      players = Players.find_all(Player.new(id: 493_603), Player.new(id: 621_438))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people?personIds=493603,621438"
      assert_equal 493_603, players.first.id
      assert_equal 621_438, players.last.id
    end

    def test_self_find_all_with_player_ids
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people?personIds=493603,621438")
        .to_return(body: '{"people":[{"id":493603},{"id":621438}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      players = Players.find_all(493_603, 621_438)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people?personIds=493603,621438"
      assert_equal 493_603, players.first.id
      assert_equal 621_438, players.last.id
    end

    def test_self_find_all_with_no_arguments
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}")
        .to_return(body: '{"people":[{"id":493603},{"id":621438}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      players = Players.find_all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sports/1/players?season=#{Time.now.year}"
      assert_equal 493_603, players.first.id
      assert_equal 621_438, players.last.id
    end
  end
end
