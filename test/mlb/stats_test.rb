require_relative "../test_helper"

module MLB
  class StatsTest < Minitest::Test
    cover Stats

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=2024&sportIds=1&stats=season")
        .to_return(body: stats_json, headers: json_headers)
      stats = Stats.find(season: 2024, group: "hitting", stats: "season")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=2024&sportIds=1&stats=season"
      assert_equal 2, stats.size
    end

    def test_self_find_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=2024&sportIds=1&stats=season")
        .to_return(body: stats_json, headers: json_headers)
      stat = Stats.find(season: 2024, group: "hitting", stats: "season").first

      assert_equal 1, stat.rank
      assert_equal 677_951, stat.player.id
      assert_equal 32, stat.stat.home_runs
    end

    def test_self_find_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=2024&sportIds=1&stats=season")
        .to_return(body: stats_json, headers: json_headers)
      sport = Sport.new(id: 1)
      stats = Stats.find(season: 2024, group: "hitting", stats: "season", sport:)

      assert_equal 2, stats.size
    end

    def test_self_find_defaults
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=#{year}&sportIds=1&stats=season")
        .to_return(body: '{"stats":[]}', headers: json_headers)
      stats = Stats.find

      assert_requested :get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=#{year}&sportIds=1&stats=season"
      assert_equal 0, stats.size
    end

    def test_self_find_returns_first_group
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats?group=hitting&season=2024&sportIds=1&stats=season")
        .to_return(body: multiple_groups_json, headers: json_headers)
      stats = Stats.find(season: 2024, group: "hitting", stats: "season")

      assert_equal 677_951, stats.first.player.id
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def stats_json
      '{"copyright":"Copyright","stats":[{"splits":[' \
        '{"season":"2024","stat":{"gamesPlayed":161,"homeRuns":32,"rbi":109},' \
        '"team":{"id":118,"name":"Kansas City Royals"},' \
        '"player":{"id":677951,"fullName":"Bobby Witt Jr."},' \
        '"rank":1,"position":{"code":"6","name":"Shortstop"}},' \
        '{"season":"2024","stat":{"gamesPlayed":159,"homeRuns":30,"rbi":103},' \
        '"team":{"id":141,"name":"Toronto Blue Jays"},' \
        '"player":{"id":665489,"fullName":"Vladimir Guerrero Jr."},' \
        '"rank":2,"position":{"code":"3","name":"First Base"}}]}]}'
    end

    def multiple_groups_json
      '{"stats":[{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":32},"player":{"id":677951},"rank":1}]},' \
        '{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":30},"player":{"id":665489},"rank":1}]}]}'
    end
  end

  class PlayerStatTest < Minitest::Test
    cover PlayerStat

    def test_equality
      stat1 = PlayerStat.new(player: Player.new(id: 677_951), rank: 1)
      stat2 = PlayerStat.new(player: Player.new(id: 677_951), rank: 1)

      assert_equal stat1, stat2
    end

    def test_inequality
      stat1 = PlayerStat.new(player: Player.new(id: 677_951), rank: 1)
      stat2 = PlayerStat.new(player: Player.new(id: 665_489), rank: 2)

      refute_equal stat1, stat2
    end
  end
end
