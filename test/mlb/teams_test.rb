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
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=11")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.all(season: 1983, sport: 11).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=11"
      assert_equal 144, team.id
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=11")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.all(season: 1983, sport: Sport.new(id: 11)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams?season=1983&sportId=11"
      assert_equal 144, team.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":144},{"id":145}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(Team.new(id: 144))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=1"
      assert_equal 144, team.id
    end

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=1")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(144)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=1"
      assert_equal 144, team.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(144, sport: 11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=11"
      assert_equal 144, team.id
    end

    def test_self_find_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=11")
        .to_return(body: '{"teams":[{"id":144}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      team = Teams.find(144, sport: Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/144?season=#{Time.now.year}&sportId=11"
      assert_equal 144, team.id
    end
  end
end
