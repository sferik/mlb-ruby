require_relative "collection"
require_relative "game_type"

module MLB
  # Provides methods for fetching game types from the API
  #
  # @example Fetch all game types
  #   MLB::GameTypes.all #=> [#<MLB::GameType>, ...]
  class GameTypes < Collection
    collection endpoint: "gameTypes", item_type: GameType, collection_name: :game_types
  end
end
