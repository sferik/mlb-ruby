require_relative "../test_helper"

module MLB
  class TeamStatsTest < Minitest::Test
    cover TeamStats

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=2024&stats=season")
        .to_return(body: team_stats_json, headers: json_headers)
      stats = TeamStats.find(season: 2024, group: "hitting", stats: "season")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=2024&stats=season"
      assert_equal 2, stats.size
    end

    def test_self_find_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=2024&stats=season")
        .to_return(body: team_stats_json, headers: json_headers)
      stat = TeamStats.find(season: 2024, group: "hitting", stats: "season").first

      assert_equal 1, stat.rank
      assert_equal 147, stat.team.id
      assert_equal 237, stat.stat.home_runs
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=#{year}&stats=season")
        .to_return(body: '{"stats":[]}', headers: json_headers)
      stats = TeamStats.find

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=#{year}&stats=season"
      assert_equal 0, stats.size
    end

    def test_self_find_returns_first_group
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/stats?group=hitting&season=2024&stats=season")
        .to_return(body: multiple_groups_json, headers: json_headers)
      stats = TeamStats.find(season: 2024, group: "hitting", stats: "season")

      assert_equal 147, stats.first.team.id
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def team_stats_json
      '{"stats":[{"splits":[' \
        '{"season":"2024","stat":{"gamesPlayed":162,"runs":829,"doubles":274,' \
        '"triples":16,"homeRuns":237,"strikeOuts":1421,"baseOnBalls":529,' \
        '"hits":1421,"avg":".257","atBats":5532,"obp":".328","slg":".453",' \
        '"ops":".781","stolenBases":118,"rbi":792},' \
        '"team":{"id":147,"name":"New York Yankees"},"rank":1},' \
        '{"season":"2024","stat":{"gamesPlayed":162,"runs":800,"homeRuns":200},' \
        '"team":{"id":111,"name":"Boston Red Sox"},"rank":2}]}]}'
    end

    def multiple_groups_json
      '{"stats":[{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":237},"team":{"id":147},"rank":1}]},' \
        '{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":200},"team":{"id":111},"rank":1}]}]}'
    end
  end

  class TeamStatTest < Minitest::Test
    cover TeamStat

    def test_equality
      stat1 = TeamStat.new(team: Team.new(id: 147), rank: 1)
      stat2 = TeamStat.new(team: Team.new(id: 147), rank: 1)

      assert_equal stat1, stat2
    end

    def test_inequality
      stat1 = TeamStat.new(team: Team.new(id: 147), rank: 1)
      stat2 = TeamStat.new(team: Team.new(id: 111), rank: 2)

      refute_equal stat1, stat2
    end
  end
end
