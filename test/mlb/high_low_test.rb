require_relative "../test_helper"

module MLB
  class HighLowTest < Minitest::Test
    cover HighLow

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/highLow/team?season=2024")
        .to_return(body: high_low_json, headers: json_headers)
      results = HighLow.find(org_type: "team", season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/highLow/team?season=2024"
      assert_equal 2, results.size
      assert_equal 1, results.first.rank
      assert_equal 111, results.first.team.id
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/highLow/team?season=#{year}")
        .to_return(body: '{"highLowResults":[]}', headers: json_headers)
      results = HighLow.find(org_type: "team")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/highLow/team?season=#{year}"
      assert_equal 0, results.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def high_low_json
      '{"copyright":"Copyright","highLowResults":[' \
        '{"group":{"displayName":"hitting"},"splits":[' \
        '{"season":"2024","team":{"id":111,"name":"Boston Red Sox"},' \
        '"opponent":{"id":145,"name":"Chicago White Sox"},' \
        '"date":"2024-06-06","isHome":false,"rank":1},' \
        '{"season":"2024","team":{"id":142,"name":"Minnesota Twins"},' \
        '"opponent":{"id":115,"name":"Colorado Rockies"},' \
        '"date":"2024-06-12","isHome":true,"rank":1}]}]}'
    end
  end

  class HighLowResultTest < Minitest::Test
    cover HighLowResult

    def test_equality
      result1 = HighLowResult.new(team: Team.new(id: 111), date: "2024-06-06", rank: 1)
      result2 = HighLowResult.new(team: Team.new(id: 111), date: "2024-06-06", rank: 1)

      assert_equal result1, result2
    end

    def test_inequality
      result1 = HighLowResult.new(team: Team.new(id: 111), date: "2024-06-06", rank: 1)
      result2 = HighLowResult.new(team: Team.new(id: 142), date: "2024-06-12", rank: 2)

      refute_equal result1, result2
    end

    def test_home?
      result = HighLowResult.new(is_home: true)

      assert_predicate result, :home?
    end

    def test_not_home?
      result = HighLowResult.new(is_home: false)

      refute_predicate result, :home?
    end
  end
end
