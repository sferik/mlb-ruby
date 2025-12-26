require_relative "../test_helper"

module MLB
  class ScheduleTest < Minitest::Test
    cover Schedule

    def test_self_games_with_date
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?date=2024-07-04&sportId=1")
        .to_return(body: '{"copyright":"Copyright","totalGames":1,"dates":[{"date":"2024-07-04",' \
                         '"totalGames":1,"games":[{"gamePk":744834,"gameType":"R"}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Schedule.games(date: Date.new(2024, 7, 4))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/schedule?date=2024-07-04&sportId=1"
      assert_equal 1, games.size
      assert_equal 744_834, games.first.game_pk
    end

    def test_self_games_with_team
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?" \
                         "date=2024-07-04&sportId=1&teamId=147")
        .to_return(body: '{"copyright":"Copyright","totalGames":1,"dates":[' \
                         '{"date":"2024-07-04","totalGames":1,"games":[{"gamePk":745726}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Schedule.games(date: Date.new(2024, 7, 4), team: 147)

      assert_equal 1, games.size
      assert_equal 745_726, games.first.game_pk
    end

    def test_self_games_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?" \
                         "date=2024-07-04&sportId=1&teamId=147")
        .to_return(body: '{"copyright":"Copyright","totalGames":1,"dates":[' \
                         '{"date":"2024-07-04","totalGames":1,"games":[{"gamePk":745726}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Team.new(id: 147)
      games = Schedule.games(date: Date.new(2024, 7, 4), team:)

      assert_equal 1, games.size
    end

    def test_self_games_defaults_to_today
      today = Date.today
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?date=#{today}&sportId=1")
        .to_return(body: '{"copyright":"Copyright","totalGames":0,"dates":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Schedule.games

      assert_equal 0, games.size
    end

    def test_self_games_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?date=2024-07-04&sportId=11")
        .to_return(body: '{"copyright":"Copyright","totalGames":0,"dates":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Schedule.games(date: Date.new(2024, 7, 4), sport: 11)

      assert_equal 0, games.size
    end

    def test_self_games_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/schedule?date=2024-07-04&sportId=11")
        .to_return(body: '{"copyright":"Copyright","totalGames":0,"dates":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Schedule.games(date: Date.new(2024, 7, 4), sport: Sport.new(id: 11))

      assert_equal 0, games.size
    end
  end
end
