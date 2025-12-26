require_relative "../test_helper"

module MLB
  class AlumniTest < Minitest::Test
    cover Alumni

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/alumni?season=2024")
        .to_return(body: alumni_json, headers: json_headers)
      players = Alumni.find(team: 147, season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/alumni?season=2024"
      assert_equal 2, players.size
      assert_equal 609_280, players.first.id
      assert_equal "Miguel Andujar", players.first.full_name
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/alumni?season=2024")
        .to_return(body: alumni_json, headers: json_headers)
      team = Team.new(id: 147)
      players = Alumni.find(team:, season: 2024)

      assert_equal 2, players.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/alumni?season=#{year}")
        .to_return(body: '{"people":[]}', headers: json_headers)
      players = Alumni.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/alumni?season=#{year}"
      assert_equal 0, players.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def alumni_json
      '{"copyright":"Copyright","people":[' \
        '{"id":609280,"fullName":"Miguel Andujar"},' \
        '{"id":664056,"fullName":"Harrison Bader"}]}'
    end
  end
end
