require_relative "../test_helper"

module MLB
  class TeamLeadersTest < Minitest::Test
    cover TeamLeaders

    def test_self_find_with_team_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=2024")
        .to_return(body: team_leaders_json, headers: json_headers)
      leaders = TeamLeaders.find(team: 147, category: "homeRuns", season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=2024"
      assert_equal 2, leaders.size
    end

    def test_self_find_attributes
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=2024")
        .to_return(body: team_leaders_json, headers: json_headers)
      leader = TeamLeaders.find(team: 147, category: "homeRuns", season: 2024).first

      assert_equal 1, leader.rank
      assert_equal "58", leader.value
      assert_equal 592_450, leader.person.id
    end

    def test_self_find_with_team_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=2024")
        .to_return(body: team_leaders_json, headers: json_headers)
      team = Team.new(id: 147)
      leaders = TeamLeaders.find(team:, category: "homeRuns", season: 2024)

      assert_equal 2, leaders.size
    end

    def test_self_find_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=#{year}")
        .to_return(body: '{"teamLeaders":[]}', headers: json_headers)
      leaders = TeamLeaders.find(team: 147, category: "homeRuns")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=#{year}"
      assert_equal 0, leaders.size
    end

    def test_self_find_returns_first_category
      stub_request(:get, "https://statsapi.mlb.com/api/v1/teams/147/leaders?leaderCategories=homeRuns&season=2024")
        .to_return(body: multiple_categories_json, headers: json_headers)
      leaders = TeamLeaders.find(team: 147, category: "homeRuns", season: 2024)

      assert_equal "58", leaders.first.value
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def team_leaders_json
      '{"copyright":"Copyright","teamLeaders":[' \
        '{"leaderCategory":"homeRuns","season":"2024","leaders":[' \
        '{"rank":1,"value":"58","person":{"id":592450,"fullName":"Aaron Judge"},' \
        '"team":{"id":147,"name":"New York Yankees"},"season":"2024"},' \
        '{"rank":2,"value":"41","person":{"id":665742,"fullName":"Juan Soto"},' \
        '"team":{"id":147,"name":"New York Yankees"},"season":"2024"}]}]}'
    end

    def multiple_categories_json
      '{"copyright":"Copyright","teamLeaders":[' \
        '{"leaderCategory":"homeRuns","season":"2024","leaders":[' \
        '{"rank":1,"value":"58","person":{"id":592450},"team":{"id":147},"season":"2024"}]},' \
        '{"leaderCategory":"homeRuns","season":"2024","leaders":[' \
        '{"rank":1,"value":"31","person":{"id":607074},"team":{"id":147},"season":"2024"}]}]}'
    end
  end

  class TeamLeaderTest < Minitest::Test
    cover TeamLeader

    def test_equality
      leader1 = TeamLeader.new(rank: 1, person: Player.new(id: 592_450))
      leader2 = TeamLeader.new(rank: 1, person: Player.new(id: 592_450))

      assert_equal leader1, leader2
    end

    def test_inequality
      leader1 = TeamLeader.new(rank: 1, person: Player.new(id: 592_450))
      leader2 = TeamLeader.new(rank: 2, person: Player.new(id: 665_742))

      refute_equal leader1, leader2
    end
  end
end
