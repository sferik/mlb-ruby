require_relative "../test_helper"

module MLB
  class MetricsTest < Minitest::Test
    cover Metrics

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/metrics")
        .to_return(body: '[{"name":"launchSpeed","metricId":1,"group":"hitting","unit":"MPH"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      metric = Metrics.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/metrics"
      assert_equal 1, metric.metric_id
      assert_equal "hitting", metric.group
    end
  end
end
