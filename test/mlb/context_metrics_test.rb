require_relative "../test_helper"

module MLB
  class SacFlyProbabilityTest < Minitest::Test
    cover SacFlyProbability

    def test_equality_by_probability
      assert_equal SacFlyProbability.new(probability: 0.25), SacFlyProbability.new(probability: 0.25)
    end

    def test_inequality_by_probability
      refute_equal SacFlyProbability.new(probability: 0.25), SacFlyProbability.new(probability: 0.30)
    end
  end

  class ContextMetricsTest < Minitest::Test
    cover ContextMetrics

    def test_find_with_game_pk
      stub_request(:get, api_url(745_571)).to_return(body: response_json, headers: json_headers)

      metrics = ContextMetrics.find(game: 745_571)

      assert_in_delta 0.52, metrics.home_win_probability
      assert_in_delta 0.48, metrics.away_win_probability
    end

    def test_find_with_game_object
      stub_request(:get, api_url(745_571)).to_return(body: response_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)

      metrics = ContextMetrics.find(game: game)

      assert_in_delta 0.52, metrics.home_win_probability
    end

    def test_find_includes_sac_fly_probabilities
      stub_request(:get, api_url(745_571)).to_return(body: response_with_sac_fly_json, headers: json_headers)

      metrics = ContextMetrics.find(game: 745_571)

      assert_in_delta 0.25, metrics.left_field_sac_fly_probability.probability
      assert_in_delta 0.30, metrics.center_field_sac_fly_probability.probability
      assert_in_delta 0.35, metrics.right_field_sac_fly_probability.probability
    end

    private

    def api_url(game_pk)
      "https://statsapi.mlb.com/api/v1/game/#{game_pk}/contextMetrics"
    end

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def response_json
      '{"homeWinProbability":0.52,"awayWinProbability":0.48,' \
        '"leftFieldSacFlyProbability":{},' \
        '"centerFieldSacFlyProbability":{},' \
        '"rightFieldSacFlyProbability":{}}'
    end

    def response_with_sac_fly_json
      '{"homeWinProbability":0.52,"awayWinProbability":0.48,' \
        '"leftFieldSacFlyProbability":{"probability":0.25},' \
        '"centerFieldSacFlyProbability":{"probability":0.30},' \
        '"rightFieldSacFlyProbability":{"probability":0.35}}'
    end
  end
end
