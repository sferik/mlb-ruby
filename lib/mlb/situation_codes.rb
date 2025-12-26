require_relative "collection"
require_relative "situation_code"

module MLB
  # Provides methods for fetching situation codes from the API
  #
  # @example Fetch all situation codes
  #   MLB::SituationCodes.all #=> [#<MLB::SituationCode>, ...]
  class SituationCodes < Collection
    collection endpoint: "situationCodes", item_type: SituationCode, collection_name: :situation_codes
  end
end
