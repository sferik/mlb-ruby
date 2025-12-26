require_relative "collection"
require_relative "wind_direction"

module MLB
  # Provides methods for fetching wind directions from the API
  #
  # @example Fetch all wind directions
  #   MLB::WindDirections.all #=> [#<MLB::WindDirection>, ...]
  class WindDirections < Collection
    collection endpoint: "windDirection", item_type: WindDirection, collection_name: :wind_directions
  end
end
