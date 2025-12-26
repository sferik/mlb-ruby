require_relative "collection"
require_relative "language"

module MLB
  # Provides methods for fetching languages from the API
  #
  # @example Fetch all languages
  #   MLB::Languages.all #=> [#<MLB::Language>, ...]
  class Languages < Collection
    collection endpoint: "languages", item_type: Language, collection_name: :languages
  end
end
