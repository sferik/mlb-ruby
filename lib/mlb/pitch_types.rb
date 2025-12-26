require_relative "collection"
require_relative "pitch_type"

module MLB
  # Provides methods for fetching pitch types from the API
  #
  # @example Fetch all pitch types
  #   MLB::PitchTypes.all #=> [#<MLB::PitchType>, ...]
  class PitchTypes < Collection
    collection endpoint: "pitchTypes", item_type: PitchType, collection_name: :pitch_types
  end
end
