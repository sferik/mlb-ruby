require_relative "collection"
require_relative "sky"

module MLB
  # Provides methods for fetching sky conditions from the API
  #
  # @example Fetch all sky conditions
  #   MLB::Skies.all #=> [#<MLB::Sky>, ...]
  class Skies < Collection
    collection endpoint: "sky", item_type: Sky, collection_name: :skies
  end
end
