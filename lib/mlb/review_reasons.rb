require_relative "collection"
require_relative "review_reason"

module MLB
  # Provides methods for fetching review reasons from the API
  #
  # @example Fetch all review reasons
  #   MLB::ReviewReasons.all #=> [#<MLB::ReviewReason>, ...]
  class ReviewReasons < Collection
    collection endpoint: "reviewReasons", item_type: ReviewReason, collection_name: :review_reasons
  end
end
