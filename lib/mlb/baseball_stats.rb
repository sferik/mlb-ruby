require_relative "collection"
require_relative "baseball_stat"

module MLB
  # Provides methods for fetching baseball statistic types from the API
  #
  # @example Fetch all baseball stats
  #   MLB::BaseballStats.all #=> [#<MLB::BaseballStat>, ...]
  class BaseballStats < Collection
    collection endpoint: "baseballStats", item_type: BaseballStat, collection_name: :stats
  end
end
