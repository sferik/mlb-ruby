require_relative "../test_helper"

module MLB
  class MetricTest < Minitest::Test
    cover Metric

    def test_objects_with_same_metric_id_are_equal
      metric1 = Metric.new(metric_id: 1)
      metric2 = Metric.new(metric_id: 1)

      assert_equal metric1, metric2
    end
  end
end
