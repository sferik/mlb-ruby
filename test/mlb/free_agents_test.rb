require_relative "../test_helper"

module MLB
  class FreeAgentsTest < Minitest::Test
    cover FreeAgents

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/freeAgents?season=2024")
        .to_return(body: free_agents_json, headers: json_headers)
      agents = FreeAgents.all(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people/freeAgents?season=2024"
      assert_equal 1, agents.size
      assert_equal 642_715, agents.first.player.id
    end

    def test_self_all_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/freeAgents?season=#{year}")
        .to_return(body: '{"copyright":"Copyright","freeAgents":[]}', headers: json_headers)
      agents = FreeAgents.all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people/freeAgents?season=#{year}"
      assert_equal 0, agents.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def free_agents_json
      '{"copyright":"Copyright","freeAgents":[{"player":{"id":642715,' \
        '"fullName":"Willy Adames"},"originalTeam":{"id":158,"name":"Milwaukee Brewers"},' \
        '"newTeam":{"id":137,"name":"San Francisco Giants"},"notes":"Seven-Year Contract",' \
        '"dateSigned":"2024-12-10","dateDeclared":"2024-10-31","position":{"code":"6"}}]}'
    end
  end
end
