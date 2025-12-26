require_relative "../test_helper"

module MLB
  class SingleTeamStatsTest < Minitest::Test
    cover SingleTeamStats

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=2024&stats=season")
        .to_return(body: single_team_stats_json, headers: json_headers)
      stats = SingleTeamStats.find(team: 147, season: 2024, group: "hitting", stats: "season")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=2024&stats=season"
      assert_equal 1, stats.size
    end

    def test_self_find_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=2024&stats=season")
        .to_return(body: single_team_stats_json, headers: json_headers)
      stat = SingleTeamStats.find(team: 147, season: 2024, group: "hitting", stats: "season").first

      assert_equal 147, stat.team.id
      assert_equal 237, stat.stat.home_runs
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=2024&stats=season")
        .to_return(body: single_team_stats_json, headers: json_headers)
      team = Team.new(id: 147)
      stats = SingleTeamStats.find(team:, season: 2024, group: "hitting", stats: "season")

      assert_equal 1, stats.size
    end

    def test_self_find_defaults
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=#{year}&stats=season")
        .to_return(body: '{"stats":[]}', headers: json_headers)
      stats = SingleTeamStats.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=#{year}&stats=season"
      assert_equal 0, stats.size
    end

    def test_self_find_returns_first_group
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/stats?group=hitting&season=2024&stats=season")
        .to_return(body: multiple_groups_json, headers: json_headers)
      stats = SingleTeamStats.find(team: 147, season: 2024, group: "hitting", stats: "season")

      assert_equal 147, stats.first.team.id
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def single_team_stats_json
      '{"copyright":"Copyright","stats":[{"splits":[' \
        '{"season":"2024","stat":{"gamesPlayed":162,"homeRuns":237},' \
        '"team":{"id":147,"name":"New York Yankees"}}]}]}'
    end

    def multiple_groups_json
      '{"stats":[{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":237},"team":{"id":147}}]},' \
        '{"splits":[' \
        '{"season":"2024","stat":{"homeRuns":200},"team":{"id":111}}]}]}'
    end
  end
end
