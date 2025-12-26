require_relative "collection"
require_relative "pitch_code"

module MLB
  # Provides methods for fetching pitch codes from the API
  #
  # @example Fetch all pitch codes
  #   MLB::PitchCodes.all #=> [#<MLB::PitchCode>, ...]
  class PitchCodes < Collection
    collection endpoint: "pitchCodes", item_type: PitchCode, collection_name: :pitch_codes
  end
end
