require_relative "collection"
require_relative "game_status"

module MLB
  # Provides methods for fetching game statuses from the API
  #
  # @example Fetch all game statuses
  #   MLB::GameStatuses.all #=> [#<MLB::GameStatus>, ...]
  class GameStatuses < Collection
    collection endpoint: "gameStatus", item_type: GameStatus, collection_name: :game_statuses
  end
end
