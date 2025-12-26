require "shale"
require_relative "play"

module MLB
  # Provides methods for fetching play-by-play data from the API
  class PlayByPlay < Shale::Mapper
    # @!attribute [rw] all_plays
    #   Returns all plays in the game
    #   @api public
    #   @example
    #     pbp.all_plays #=> [#<MLB::Play>, ...]
    #   @return [Array<Play>] all plays
    attribute :all_plays, Play, collection: true

    # @!attribute [rw] current_play
    #   Returns the current play
    #   @api public
    #   @example
    #     pbp.current_play #=> #<MLB::Play>
    #   @return [Play] the current play
    attribute :current_play, Play

    # @!attribute [rw] scoring_plays
    #   Returns indices of scoring plays
    #   @api public
    #   @example
    #     pbp.scoring_plays #=> [5, 12, 23]
    #   @return [Array<Integer>] scoring play indices
    attribute :scoring_plays, Shale::Type::Integer, collection: true

    json do
      map "allPlays", to: :all_plays
      map "currentPlay", to: :current_play
      map "scoringPlays", to: :scoring_plays
    end

    # Retrieves play-by-play data for a game
    #
    # @api public
    # @example Get play-by-play for a game
    #   MLB::PlayByPlay.find(game: 745571)
    # @example Get play-by-play for a scheduled game
    #   MLB::PlayByPlay.find(game: ScheduledGame.new(game_pk: 745571))
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [PlayByPlay] the play-by-play data
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/playByPlay")
      from_json(response)
    end
  end
end
