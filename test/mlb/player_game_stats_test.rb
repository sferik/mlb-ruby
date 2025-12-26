require_relative "../test_helper"

module MLB
  module PlayerGameStatsFixtures
    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def batting_stat_json
      '{"gamesPlayed":1,"atBats":4,"runs":1,"hits":2,"doubles":1,"triples":0,' \
        '"homeRuns":1,"rbi":3,"stolenBases":0,"baseOnBalls":1,"strikeOuts":1}'
    end

    def pitching_stat_json
      '{"gamesPlayed":1,"gamesStarted":1,"wins":1,"losses":0,"saves":0,' \
        '"inningsPitched":"7.0","hits":5,"runs":2,"earnedRuns":2,"homeRuns":1,' \
        '"baseOnBalls":2,"strikeOuts":8,"numberOfPitches":95}'
    end

    def player_game_stats_json
      split = %({"stat":#{batting_stat_json},"team":{"id":119},"player":{"id":660271}})
      %({"copyright":"Copyright","stats":[{"group":"hitting","splits":[#{split}]}]})
    end

    def pitching_stats_json
      split = %({"stat":#{pitching_stat_json},"team":{"id":119},"player":{"id":660271}})
      %({"copyright":"Copyright","stats":[{"group":"pitching","splits":[#{split}]}]})
    end

    def empty_splits_json
      '{"copyright":"Copyright","stats":[{"group":"hitting","splits":[]}]}'
    end

    def multi_split_batting_json
      first_split = '{"stat":{"gamesPlayed":1,"atBats":4,"runs":1,"hits":2,"doubles":1,"triples":0,' \
                    '"homeRuns":1,"rbi":3,"stolenBases":0,"baseOnBalls":1,"strikeOuts":1},"team":{"id":119},"player":{"id":660271}}'
      second_split = '{"stat":{"gamesPlayed":1,"atBats":3,"runs":0,"hits":1,"doubles":0,"triples":0,' \
                     '"homeRuns":0,"rbi":0,"stolenBases":0,"baseOnBalls":0,"strikeOuts":2},"team":{"id":147},"player":{"id":660271}}'
      %({"copyright":"Copyright","stats":[{"group":"hitting","splits":[#{first_split},#{second_split}]}]})
    end

    def multi_split_pitching_json
      first_split = '{"stat":{"gamesPlayed":1,"gamesStarted":1,"wins":1,"losses":0,"saves":0,' \
                    '"inningsPitched":"7.0","hits":5,"runs":2,"earnedRuns":2,"homeRuns":1,' \
                    '"baseOnBalls":2,"strikeOuts":8,"numberOfPitches":95},"team":{"id":119},"player":{"id":660271}}'
      second_split = '{"stat":{"gamesPlayed":1,"gamesStarted":0,"wins":0,"losses":0,"saves":0,' \
                     '"inningsPitched":"2.0","hits":1,"runs":0,"earnedRuns":0,"homeRuns":0,' \
                     '"baseOnBalls":1,"strikeOuts":3,"numberOfPitches":30},"team":{"id":147},"player":{"id":660271}}'
      %({"copyright":"Copyright","stats":[{"group":"pitching","splits":[#{first_split},#{second_split}]}]})
    end
  end

  class PlayerGameStatsTest < Minitest::Test
    include PlayerGameStatsFixtures

    cover PlayerGameStats

    def test_self_find_with_ids
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: player_game_stats_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571"
      assert_kind_of PlayerGameStats, stats
    end

    def test_self_find_with_player_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: player_game_stats_json, headers: json_headers)
      player = Player.new(id: 660_271)
      stats = PlayerGameStats.find(player:, game: 745_571)

      assert_kind_of PlayerGameStats, stats
    end

    def test_self_find_with_game_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: player_game_stats_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      stats = PlayerGameStats.find(player: 660_271, game:)

      assert_kind_of PlayerGameStats, stats
    end

    def test_batting
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: player_game_stats_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_instance_of PlayerGameBattingStats, stats.batting
      assert_equal 4, stats.batting.at_bats
      assert_equal 2, stats.batting.hits
    end

    def test_pitching
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: pitching_stats_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_instance_of PlayerGamePitchingStats, stats.pitching
      assert_equal "7.0", stats.pitching.innings_pitched
      assert_equal 8, stats.pitching.strike_outs
    end

    def test_batting_nil_when_no_hitting_group
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: pitching_stats_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_nil stats.batting
    end

    def test_pitching_nil_when_no_pitching_group
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: player_game_stats_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_nil stats.pitching
    end

    def test_batting_nil_when_no_splits
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: empty_splits_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_nil stats.batting
    end

    def test_batting_returns_first_split_when_multiple
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: multi_split_batting_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_equal 4, stats.batting.at_bats
      assert_equal 2, stats.batting.hits
    end

    def test_pitching_returns_first_split_when_multiple
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/660271/stats/game/745571")
        .to_return(body: multi_split_pitching_json, headers: json_headers)
      stats = PlayerGameStats.find(player: 660_271, game: 745_571)

      assert_equal "7.0", stats.pitching.innings_pitched
      assert_equal 95, stats.pitching.number_of_pitches
    end
  end

  class PlayerGameBattingStatsTest < Minitest::Test
    cover PlayerGameBattingStats

    def test_games_played
      assert_equal 1, sample_batting_stats.games_played
    end

    def test_at_bats
      assert_equal 4, sample_batting_stats.at_bats
    end

    def test_hits
      assert_equal 2, sample_batting_stats.hits
    end

    private

    def sample_batting_stats
      @sample_batting_stats ||= PlayerGameBattingStats.new(
        games_played: 1, at_bats: 4, runs: 1, hits: 2, doubles: 1,
        triples: 0, home_runs: 1, rbi: 3, stolen_bases: 0,
        base_on_balls: 1, strike_outs: 1
      )
    end
  end

  class PlayerGamePitchingStatsTest < Minitest::Test
    cover PlayerGamePitchingStats

    def test_games_played
      assert_equal 1, sample_pitching_stats.games_played
    end

    def test_innings_pitched
      assert_equal "7.0", sample_pitching_stats.innings_pitched
    end

    def test_number_of_pitches
      assert_equal 95, sample_pitching_stats.number_of_pitches
    end

    private

    def sample_pitching_stats
      @sample_pitching_stats ||= PlayerGamePitchingStats.new(
        games_played: 1, games_started: 1, wins: 1, losses: 0, saves: 0,
        innings_pitched: "7.0", hits: 5, runs: 2, earned_runs: 2,
        home_runs: 1, base_on_balls: 2, strike_outs: 8, number_of_pitches: 95
      )
    end
  end

  class PlayerGameStatSplitTest < Minitest::Test
    cover PlayerGameStatSplit
  end

  class PlayerGameStatGroupTest < Minitest::Test
    cover PlayerGameStatGroup
  end
end
