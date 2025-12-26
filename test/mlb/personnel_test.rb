require_relative "../test_helper"

module MLB
  class PersonnelTest < Minitest::Test
    cover Personnel

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/personnel?season=2024")
        .to_return(body: personnel_json, headers: json_headers)
      personnel = Personnel.find(team: 147, season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/personnel?season=2024"
      assert_equal 2, personnel.size
      assert_equal "Director of Player Health", personnel.first.job
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/personnel?season=2024")
        .to_return(body: personnel_json, headers: json_headers)
      team = Team.new(id: 147)
      personnel = Personnel.find(team:, season: 2024)

      assert_equal 2, personnel.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/personnel?season=#{year}")
        .to_return(body: '{"roster":[]}', headers: json_headers)
      personnel = Personnel.find(team: 147)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/personnel?season=#{year}"
      assert_equal 0, personnel.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def personnel_json
      '{"copyright":"Copyright","roster":[' \
        '{"person":{"id":693113,"fullName":"Eric Cressey"},' \
        '"job":"Director of Player Health","jobId":"DRPH"},' \
        '{"person":{"id":674480,"fullName":"Michael Schuk"},' \
        '"job":"Director of Sports Performance","jobId":"DOSP"}]}'
    end
  end
end
