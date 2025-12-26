require_relative "../test_helper"

module MLB
  class PlayByPlayTest < Minitest::Test
    cover PlayByPlay

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      pbp = PlayByPlay.find(game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay"
      assert_equal 2, pbp.all_plays.size
      assert_equal "Groundout", pbp.all_plays.first.result.event
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      pbp = PlayByPlay.find(game:)

      assert_equal 2, pbp.all_plays.size
    end

    def test_play_result_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      play = PlayByPlay.find(game: 745_571).all_plays.first

      assert_equal "field_out", play.result.event_type
      assert_equal 0, play.result.rbi
      assert_predicate play.result, :out?
    end

    def test_play_about_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      play = PlayByPlay.find(game: 745_571).all_plays.first

      assert_equal 1, play.about.inning
      assert_predicate play.about, :top_inning?
      assert_predicate play.about, :complete?
      refute_predicate play.about, :scoring_play?
    end

    def test_play_matchup_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      play = PlayByPlay.find(game: 745_571).all_plays.first

      assert_equal 596_019, play.matchup.batter.id
      assert_equal 592_836, play.matchup.pitcher.id
    end

    def test_scoring_plays
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/playByPlay")
        .to_return(body: play_by_play_json, headers: json_headers)
      pbp = PlayByPlay.find(game: 745_571)

      assert_equal [5, 12], pbp.scoring_plays
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def play_by_play_json
      "{\"copyright\":\"Copyright\",\"allPlays\":[#{play1_json},#{play2_json}],\"scoringPlays\":[5,12]}"
    end

    def play1_json
      '{"result":{"type":"atBat","event":"Groundout","eventType":"field_out",' \
        '"description":"desc","rbi":0,"awayScore":0,"homeScore":0,"isOut":true},' \
        '"about":{"atBatIndex":0,"halfInning":"top","isTopInning":true,' \
        '"inning":1,"isComplete":true,"isScoringPlay":false},' \
        '"count":{"balls":1,"strikes":1,"outs":1},' \
        '"matchup":{"batter":{"id":596019},"batSide":{"code":"L"},' \
        '"pitcher":{"id":592836},"pitchHand":{"code":"R"}}}'
    end

    def play2_json
      '{"result":{"type":"atBat","event":"Single","eventType":"single","description":"desc",' \
        '"rbi":1,"awayScore":1,"homeScore":0,"isOut":false},"about":{"atBatIndex":1,' \
        '"halfInning":"top","isTopInning":true,"inning":1,"isComplete":true,' \
        '"isScoringPlay":true},"count":{"balls":0,"strikes":0,"outs":1},' \
        '"matchup":{"batter":{"id":596019},"batSide":{"code":"L"},' \
        '"pitcher":{"id":592836},"pitchHand":{"code":"R"}}}'
    end
  end

  class PlayResultTest < Minitest::Test
    cover PlayResult

    def test_out?
      result = PlayResult.new(is_out: true)

      assert_predicate result, :out?
    end

    def test_not_out?
      result = PlayResult.new(is_out: false)

      refute_predicate result, :out?
    end
  end

  class PlayAboutTest < Minitest::Test
    cover PlayAbout

    def test_top_inning?
      about = PlayAbout.new(is_top_inning: true)

      assert_predicate about, :top_inning?
    end

    def test_complete?
      about = PlayAbout.new(is_complete: true)

      assert_predicate about, :complete?
    end

    def test_scoring_play?
      about = PlayAbout.new(is_scoring_play: true)

      assert_predicate about, :scoring_play?
    end
  end
end
