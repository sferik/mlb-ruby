require_relative "../test_helper"

module MLB
  class HomeRunDerbyTest < Minitest::Test
    cover HomeRunDerby

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      derby = HomeRunDerby.find(game: 511_101)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101"
      assert_equal 511_101, derby.info.id
      assert_equal "2024 Home Run Derby", derby.info.name
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 511_101)
      derby = HomeRunDerby.find(game:)

      assert_equal 511_101, derby.info.id
    end

    def test_derby_rounds
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      derby = HomeRunDerby.find(game: 511_101)

      assert_equal 1, derby.rounds.first.round
      assert_equal 8, derby.rounds.first.num_batters
    end

    def test_derby_matchup_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      matchup = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first

      assert_equal 1, matchup.matchup_id
    end

    def test_derby_matchup_top_seed
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      matchup = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first

      assert_equal 660_271, matchup.top_seed.id
    end

    def test_derby_matchup_bottom_seed
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      matchup = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first

      assert_equal 605_141, matchup.bottom_seed.id
    end

    def test_batter_name_and_seed
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      batter = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first.top_seed

      assert_equal "Shohei Ohtani", batter.full_name
      assert_equal 1, batter.seed
    end

    def test_batter_home_runs_and_status
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      batter = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first.top_seed

      assert_equal 20, batter.home_runs
      assert_predicate batter, :winner?
      assert_predicate batter, :bonus?
    end

    def test_derby_home_run_distance
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      hr = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first.top_seed.hits.first

      assert_equal 450, hr.total_distance
    end

    def test_derby_home_run_launch_speed
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      hr = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first.top_seed.hits.first

      assert_in_delta 112.5, hr.launch_speed
    end

    def test_derby_home_run_launch_angle
      stub_request(:get, "https://statsapi.mlb.com/api/v1/homeRunDerby/511101")
        .to_return(body: derby_json, headers: json_headers)
      hr = HomeRunDerby.find(game: 511_101).rounds.first.matchups.first.top_seed.hits.first

      assert_in_delta 28.5, hr.launch_angle
      refute_predicate hr, :bonus_time?
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def derby_json
      '{"copyright":"Copyright","info":{"id":511101,"name":"2024 Home Run Derby"},' \
        '"rounds":[{"round":1,"numBatters":8,"matchups":[{"matchupId":1,' \
        '"topSeed":{"id":660271,"fullName":"Shohei Ohtani",' \
        '"link":"/api/v1/people/660271","seed":1,"homeRuns":20,' \
        '"isWinner":true,"isBonus":true,"hits":[{"totalDistance":450,' \
        '"launchSpeed":112.5,"launchAngle":28.5,"isBonusTime":false}]},' \
        '"bottomSeed":{"id":605141,"fullName":"Mookie Betts",' \
        '"link":"/api/v1/people/605141","seed":8,"homeRuns":15,' \
        '"isWinner":false,"isBonus":false,"hits":[]}}]}]}'
    end
  end

  class DerbyBatterTest < Minitest::Test
    cover DerbyBatter

    def test_equality
      b1 = DerbyBatter.new(id: 660_271, seed: 1)
      b2 = DerbyBatter.new(id: 660_271, seed: 1)

      assert_equal b1, b2
    end

    def test_inequality
      b1 = DerbyBatter.new(id: 660_271, seed: 1)
      b2 = DerbyBatter.new(id: 605_141, seed: 8)

      refute_equal b1, b2
    end

    def test_link
      batter = DerbyBatter.new(link: "/api/v1/people/660271")

      assert_equal "/api/v1/people/660271", batter.link
    end

    def test_winner
      batter = DerbyBatter.new(is_winner: true)

      assert_predicate batter, :winner?
    end

    def test_not_winner
      batter = DerbyBatter.new(is_winner: false)

      refute_predicate batter, :winner?
    end

    def test_bonus
      batter = DerbyBatter.new(is_bonus: true)

      assert_predicate batter, :bonus?
    end

    def test_not_bonus
      batter = DerbyBatter.new(is_bonus: false)

      refute_predicate batter, :bonus?
    end
  end

  class DerbyHomeRunTest < Minitest::Test
    cover DerbyHomeRun

    def test_bonus_time
      hr = DerbyHomeRun.new(is_bonus_time: true)

      assert_predicate hr, :bonus_time?
    end

    def test_not_bonus_time
      hr = DerbyHomeRun.new(is_bonus_time: false)

      refute_predicate hr, :bonus_time?
    end
  end

  class DerbyMatchupTest < Minitest::Test
    cover DerbyMatchup
  end

  class DerbyRoundTest < Minitest::Test
    cover DerbyRound
  end

  class DerbyInfoTest < Minitest::Test
    cover DerbyInfo
  end
end
