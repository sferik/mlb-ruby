require_relative "../test_helper"

module MLB
  class TeamsTest < Minitest::Test
    cover Teams

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams?season=#{Time.now.year}&sportId=1"
      assert_equal 144, team.id
    end

    def test_self_all_with_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=1")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.all(season: 1983).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=1"
      assert_equal 144, team.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=1")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.all(season: 1983, sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=1"
      assert_equal 144, team.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":1},{"id":2}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(Team.new(id: 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1"
      assert_equal 1, team.id
    end

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1"
      assert_equal 1, team.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":1}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(1, sport: 1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/1?season=#{Time.now.year}&sportId=1"
      assert_equal 1, team.id
    end
  end
end
