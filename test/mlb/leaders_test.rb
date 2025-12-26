require_relative "../test_helper"

module MLB
  class LeadersTest < Minitest::Test
    cover Leaders

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                         "leaderCategories=homeRuns&limit=10&season=2024")
        .to_return(body: leaders_json, headers: json_headers)
      leaders = Leaders.find(category: "homeRuns", season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                             "leaderCategories=homeRuns&limit=10&season=2024"
      assert_equal 2, leaders.size
      assert_equal 1, leaders.first.rank
      assert_equal "58", leaders.first.value
    end

    def test_self_find_with_custom_limit
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                         "leaderCategories=homeRuns&limit=5&season=2024")
        .to_return(body: leaders_json, headers: json_headers)
      leaders = Leaders.find(category: "homeRuns", season: 2024, limit: 5)

      assert_equal 2, leaders.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                         "leaderCategories=homeRuns&limit=10&season=#{year}")
        .to_return(body: '{"leagueLeaders":[]}', headers: json_headers)
      leaders = Leaders.find(category: "homeRuns")

      assert_equal 0, leaders.size
    end

    def test_self_find_with_no_results
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                         "leaderCategories=unknown&limit=10&season=2024")
        .to_return(body: '{"leagueLeaders":[]}', headers: json_headers)
      leaders = Leaders.find(category: "unknown", season: 2024)

      assert_equal 0, leaders.size
    end

    def test_self_find_returns_first_category
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/leaders?" \
                         "leaderCategories=homeRuns&limit=10&season=2024")
        .to_return(body: multi_category_json, headers: json_headers)
      leaders = Leaders.find(category: "homeRuns", season: 2024)

      assert_equal "58", leaders.first.value
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def leaders_json
      '{"copyright":"Copyright","leagueLeaders":[{"leaderCategory":"homeRuns",' \
        '"season":"2024","leaders":[' \
        '{"rank":1,"value":"58","person":{"id":592450,"fullName":"Aaron Judge"},' \
        '"team":{"id":147,"name":"New York Yankees"}},' \
        '{"rank":2,"value":"54","person":{"id":660271,"fullName":"Shohei Ohtani"},' \
        '"team":{"id":119,"name":"Los Angeles Dodgers"}}]}]}'
    end

    def multi_category_json
      '{"leagueLeaders":[{"leaderCategory":"homeRuns","leaders":[' \
        '{"rank":1,"value":"58"}]},' \
        '{"leaderCategory":"rbi","leaders":[{"rank":1,"value":"130"}]}]}'
    end
  end

  class LeaderTest < Minitest::Test
    cover Leader

    def test_equality
      leader1 = Leader.new(rank: 1, person: Player.new(id: 123))
      leader2 = Leader.new(rank: 1, person: Player.new(id: 123))

      assert_equal leader1, leader2
    end

    def test_inequality
      leader1 = Leader.new(rank: 1, person: Player.new(id: 123))
      leader2 = Leader.new(rank: 2, person: Player.new(id: 456))

      refute_equal leader1, leader2
    end
  end
end
