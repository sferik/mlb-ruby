require_relative "../test_helper"

module MLB
  class WinProbabilityTest < Minitest::Test
    cover WinProbability

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/winProbability")
        .to_return(body: win_probability_json, headers: json_headers)
      entries = WinProbability.find(game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745571/winProbability"
      assert_equal 2, entries.size
      assert_equal 0, entries.first.at_bat_index
      assert_in_delta 0.52, entries.first.home_team_win_probability
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/winProbability")
        .to_return(body: win_probability_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      entries = WinProbability.find(game:)

      assert_equal 2, entries.size
    end

    def test_entry_away_team_win_probability
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/winProbability")
        .to_return(body: win_probability_json, headers: json_headers)
      entries = WinProbability.find(game: 745_571)

      assert_in_delta 0.48, entries.first.away_team_win_probability
    end

    def test_self_find_with_empty_response
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/999999/winProbability")
        .to_return(body: "[]", headers: json_headers)
      entries = WinProbability.find(game: 999_999)

      assert_empty entries
    end

    def test_self_find_handles_nil_response
      mock = Minitest::Mock.new
      mock.expect(:get, nil, ["game/999999/winProbability"])
      entries = swap_client(mock) { WinProbability.find(game: 999_999) }

      assert_empty entries
      assert_mock mock
    end

    def swap_client(mock)
      original = MLB::CLIENT
      MLB.send(:remove_const, :CLIENT)
      MLB.const_set(:CLIENT, mock)
      yield
    ensure
      MLB.send(:remove_const, :CLIENT)
      MLB.const_set(:CLIENT, original)
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def win_probability_json
      '[{"atBatIndex":0,"homeTeamWinProbability":0.52,"awayTeamWinProbability":0.48},' \
        '{"atBatIndex":1,"homeTeamWinProbability":0.55,"awayTeamWinProbability":0.45}]'
    end
  end

  class WinProbabilityEntryTest < Minitest::Test
    cover WinProbabilityEntry

    def test_equality
      entry1 = WinProbabilityEntry.new(at_bat_index: 0, home_team_win_probability: 0.52)
      entry2 = WinProbabilityEntry.new(at_bat_index: 0, home_team_win_probability: 0.52)

      assert_equal entry1, entry2
    end

    def test_inequality
      entry1 = WinProbabilityEntry.new(at_bat_index: 0, home_team_win_probability: 0.52)
      entry2 = WinProbabilityEntry.new(at_bat_index: 1, home_team_win_probability: 0.55)

      refute_equal entry1, entry2
    end
  end
end
