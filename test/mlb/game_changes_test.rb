require_relative "../test_helper"

module MLB
  class ChangedGameTest < Minitest::Test
    cover ChangedGame

    def test_equality_by_game_pk
      assert_equal ChangedGame.new(game_pk: 745_571), ChangedGame.new(game_pk: 745_571)
    end

    def test_inequality_by_game_pk
      refute_equal ChangedGame.new(game_pk: 745_571), ChangedGame.new(game_pk: 745_572)
    end
  end

  class ChangedGameDateTest < Minitest::Test
    cover ChangedGameDate
  end

  class GameChangesTest < Minitest::Test
    cover GameChanges

    def test_since_returns_changed_games
      stub_request(:get, api_url("updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: response_json, headers: json_headers)

      games = GameChanges.since(updated_since: "2024-06-15T12:00:00Z")

      assert_equal 3, games.size
      assert_equal 745_571, games.first.game_pk
    end

    def test_since_filters_by_sport_id
      stub_request(:get, api_url("sportId=1&updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: response_json, headers: json_headers)

      games = GameChanges.since(updated_since: "2024-06-15T12:00:00Z", sport_id: 1)

      assert_equal 3, games.size
    end

    def test_since_filters_by_season
      stub_request(:get, api_url("season=2024&updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: response_json, headers: json_headers)

      games = GameChanges.since(updated_since: "2024-06-15T12:00:00Z", season: 2024)

      assert_equal 3, games.size
    end

    def test_since_filters_by_game_type
      stub_request(:get, api_url("gameType=R&updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: response_json, headers: json_headers)

      games = GameChanges.since(updated_since: "2024-06-15T12:00:00Z", game_type: "R")

      assert_equal 3, games.size
    end

    def test_since_accepts_all_filters
      stub_request(:get, api_url("gameType=R&season=2024&sportId=1&updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: response_json, headers: json_headers)

      games = GameChanges.since(
        updated_since: "2024-06-15T12:00:00Z",
        sport_id: 1,
        season: 2024,
        game_type: "R"
      )

      assert_equal 3, games.size
    end

    def test_since_converts_timestamp_with_to_s
      stub_request(:get, api_url("updatedSince=custom-timestamp"))
        .to_return(body: empty_response_json, headers: json_headers)
      timestamp = Minitest::Mock.new
      timestamp.expect(:to_s, "custom-timestamp")

      GameChanges.since(updated_since: timestamp)

      assert_mock timestamp
    end

    def test_since_returns_empty_array_when_no_changes
      stub_request(:get, api_url("updatedSince=2024-06-15T12:00:00Z"))
        .to_return(body: empty_response_json, headers: json_headers)

      games = GameChanges.since(updated_since: "2024-06-15T12:00:00Z")

      assert_empty games
    end

    private

    def api_url(query)
      "https://statsapi.mlb.com/api/v1/game/changes?#{query}"
    end

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def response_json
      <<~JSON.chomp
        {"copyright":"Copyright","dates":[{"date":"2024-06-15","games":[{"gamePk":745571},{"gamePk":745572}]},{"date":"2024-06-16","games":[{"gamePk":745580}]}]}
      JSON
    end

    def empty_response_json
      '{"copyright":"Copyright","dates":[]}'
    end
  end
end
