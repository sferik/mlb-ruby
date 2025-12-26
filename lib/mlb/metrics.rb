require_relative "collection"
require_relative "metric"

module MLB
  # Provides methods for fetching metrics from the API
  #
  # @example Fetch all metrics
  #   MLB::Metrics.all #=> [#<MLB::Metric>, ...]
  class Metrics < Collection
    collection endpoint: "metrics", item_type: Metric, collection_name: :metrics
  end
end
