require_relative "../test_helper"

module MLB
  class BoxscoreTest < Minitest::Test
    cover Boxscore

    def test_self_find_with_game_pk
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/boxscore")
        .to_return(body: boxscore_json, headers: json_headers)
      boxscore = Boxscore.find(game: 745_726)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745726/boxscore"
      assert_equal 113, boxscore.teams.away.team.id
      assert_equal 147, boxscore.teams.home.team.id
    end

    def test_self_find_with_game_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/boxscore")
        .to_return(body: boxscore_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_726)
      boxscore = Boxscore.find(game:)

      assert_equal 113, boxscore.teams.away.team.id
    end

    def test_team_batting_stats
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/boxscore")
        .to_return(body: boxscore_json, headers: json_headers)
      boxscore = Boxscore.find(game: 745_726)
      batting = boxscore.teams.away.team_stats.batting

      assert_equal 8, batting.runs
      assert_equal 9, batting.hits
      assert_equal 3, batting.home_runs
    end

    def test_team_pitching_stats
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/boxscore")
        .to_return(body: boxscore_json, headers: json_headers)
      boxscore = Boxscore.find(game: 745_726)
      pitching = boxscore.teams.home.team_stats.pitching

      assert_equal 8, pitching.runs
      assert_equal "9.0", pitching.innings_pitched
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def boxscore_json
      '{"copyright":"Copyright","teams":{' \
        '"away":{"team":{"id":113,"name":"Cincinnati Reds"},' \
        '"teamStats":{"batting":{"runs":8,"hits":9,"homeRuns":3,"avg":".227"},' \
        '"pitching":{"runs":4,"earnedRuns":4,"inningsPitched":"9.0"}}},' \
        '"home":{"team":{"id":147,"name":"New York Yankees"},' \
        '"teamStats":{"batting":{"runs":4,"hits":7,"homeRuns":3},' \
        '"pitching":{"runs":8,"earnedRuns":7,"inningsPitched":"9.0"}}}}}'
    end
  end
end
