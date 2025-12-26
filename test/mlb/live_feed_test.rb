require_relative "../test_helper"

module MLB
  class LiveFeedTest < Minitest::Test
    cover LiveFeed

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      feed = LiveFeed.find(game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live"
      assert_equal 745_571, feed.game_pk
      assert_equal "/api/v1.1/game/745571/feed/live", feed.link
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      feed = LiveFeed.find(game:)

      assert_equal 745_571, feed.game_pk
    end

    def test_game_data_datetime
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      feed = LiveFeed.find(game: 745_571)

      assert_equal "2024-10-01T23:08:00Z", feed.game_data.datetime.date_time
      assert_equal "night", feed.game_data.datetime.day_night
    end

    def test_game_data_teams
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      feed = LiveFeed.find(game: 745_571)

      assert_equal 147, feed.game_data.teams.away.id
      assert_equal 119, feed.game_data.teams.home.id
    end

    def test_game_data_venue
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      feed = LiveFeed.find(game: 745_571)

      assert_equal 17, feed.game_data.venue.id
    end

    def test_live_data_plays_count
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      plays = LiveFeed.find(game: 745_571).live_data.plays

      assert_equal 1, plays.all_plays.size
    end

    def test_live_data_plays_event
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/feed/live")
        .to_return(body: live_feed_json, headers: json_headers)
      play = LiveFeed.find(game: 745_571).live_data.plays.all_plays.first

      assert_equal "Groundout", play.result.event
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def live_feed_json
      '{"copyright":"Copyright","gamePk":745571,' \
        '"link":"/api/v1.1/game/745571/feed/live",' \
        '"gameData":{"datetime":{"dateTime":"2024-10-01T23:08:00Z",' \
        '"originalDate":"2024-10-01","dayNight":"night","time":"7:08","ampm":"PM"},' \
        '"teams":{"away":{"id":147},"home":{"id":119}},' \
        '"venue":{"id":17}},' \
        '"liveData":{"plays":{"allPlays":[' \
        '{"result":{"event":"Groundout","eventType":"field_out"},' \
        '"about":{"atBatIndex":0,"inning":1,"isTopInning":true}}],' \
        '"scoringPlays":[]},"linescore":{},"boxscore":{}}}'
    end
  end

  class GameDataTest < Minitest::Test
    cover GameData

    def test_datetime_time_and_am_pm
      datetime = GameDateTime.new(time: "7:08", am_pm: "PM")

      assert_equal "7:08", datetime.time
      assert_equal "PM", datetime.am_pm
    end

    def test_datetime_original_date
      datetime = GameDateTime.new(original_date: "2024-10-01")

      assert_equal "2024-10-01", datetime.original_date
    end
  end

  class LiveDataTest < Minitest::Test
    cover LiveData

    def test_scoring_plays
      plays = LivePlays.new(scoring_plays: [5, 12])

      assert_equal [5, 12], plays.scoring_plays
    end

    def test_current_play
      play = Play.new
      plays = LivePlays.new(current_play: play)

      assert_equal play, plays.current_play
    end
  end

  class LivePlaysTest < Minitest::Test
    cover LivePlays
  end

  class GameDateTimeTest < Minitest::Test
    cover GameDateTime

    def test_day?
      day_datetime = GameDateTime.new(day_night: "day")

      assert_predicate day_datetime, :day?
      refute_predicate day_datetime, :night?

      night_datetime = GameDateTime.new(day_night: "night")

      refute_predicate night_datetime, :day?
    end

    def test_night?
      night_datetime = GameDateTime.new(day_night: "night")

      assert_predicate night_datetime, :night?
      refute_predicate night_datetime, :day?

      day_datetime = GameDateTime.new(day_night: "day")

      refute_predicate day_datetime, :night?
    end

    def test_am?
      am_datetime = GameDateTime.new(am_pm: "AM")

      assert_predicate am_datetime, :am?
      refute_predicate am_datetime, :pm?

      pm_datetime = GameDateTime.new(am_pm: "PM")

      refute_predicate pm_datetime, :am?
    end

    def test_pm?
      pm_datetime = GameDateTime.new(am_pm: "PM")

      assert_predicate pm_datetime, :pm?
      refute_predicate pm_datetime, :am?

      am_datetime = GameDateTime.new(am_pm: "AM")

      refute_predicate am_datetime, :pm?
    end
  end

  class GameTeamsTest < Minitest::Test
    cover GameTeams
  end
end
