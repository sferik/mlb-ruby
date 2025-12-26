require_relative "collection"
require_relative "platform"

module MLB
  # Provides methods for fetching platforms from the API
  #
  # @example Fetch all platforms
  #   MLB::Platforms.all #=> [#<MLB::Platform>, ...]
  class Platforms < Collection
    collection endpoint: "platforms", item_type: Platform, collection_name: :platforms
  end
end
