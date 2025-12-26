require_relative "collection"
require_relative "position"

module MLB
  # Provides methods for fetching positions from the API
  #
  # @example Fetch all positions
  #   MLB::Positions.all #=> [#<MLB::Position>, ...]
  class Positions < Collection
    collection endpoint: "positions", item_type: Position, collection_name: :positions
  end
end
