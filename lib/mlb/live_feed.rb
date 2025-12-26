require "shale"
require_relative "game_data"
require_relative "play"
require_relative "linescore"
require_relative "boxscore"

module MLB
  # Represents the plays section of the live feed
  class LivePlays < Shale::Mapper
    # @!attribute [rw] all_plays
    #   Returns all plays in the game
    #   @api public
    #   @example
    #     plays.all_plays #=> [#<MLB::Play>, ...]
    #   @return [Array<Play>] all plays
    attribute :all_plays, Play, collection: true

    # @!attribute [rw] current_play
    #   Returns the current play
    #   @api public
    #   @example
    #     plays.current_play #=> #<MLB::Play>
    #   @return [Play] the current play
    attribute :current_play, Play

    # @!attribute [rw] scoring_plays
    #   Returns indices of scoring plays
    #   @api public
    #   @example
    #     plays.scoring_plays #=> [5, 12, 23]
    #   @return [Array<Integer>] scoring play indices
    attribute :scoring_plays, Shale::Type::Integer, collection: true

    json do
      map "allPlays", to: :all_plays
      map "currentPlay", to: :current_play
      map "scoringPlays", to: :scoring_plays
    end
  end

  # Represents the live data section of the feed
  class LiveData < Shale::Mapper
    # @!attribute [rw] plays
    #   Returns the plays data
    #   @api public
    #   @example
    #     live_data.plays #=> #<MLB::LivePlays>
    #   @return [LivePlays] the plays
    attribute :plays, LivePlays

    # @!attribute [rw] linescore
    #   Returns the linescore
    #   @api public
    #   @example
    #     live_data.linescore #=> #<MLB::Linescore>
    #   @return [Linescore] the linescore
    attribute :linescore, Linescore

    # @!attribute [rw] boxscore
    #   Returns the boxscore
    #   @api public
    #   @example
    #     live_data.boxscore #=> #<MLB::Boxscore>
    #   @return [Boxscore] the boxscore
    attribute :boxscore, Boxscore

    json do
      map "plays", to: :plays
      map "linescore", to: :linescore
      map "boxscore", to: :boxscore
    end
  end

  # Represents the live game feed data
  class LiveFeed < Shale::Mapper
    # @!attribute [rw] game_pk
    #   Returns the game primary key
    #   @api public
    #   @example
    #     feed.game_pk #=> 745571
    #   @return [Integer] the game PK
    attribute :game_pk, Shale::Type::Integer

    # @!attribute [rw] link
    #   Returns the API link
    #   @api public
    #   @example
    #     feed.link #=> "/api/v1.1/game/745571/feed/live"
    #   @return [String] the link
    attribute :link, Shale::Type::String

    # @!attribute [rw] game_data
    #   Returns the game metadata
    #   @api public
    #   @example
    #     feed.game_data #=> #<MLB::GameData>
    #   @return [GameData] the game data
    attribute :game_data, GameData

    # @!attribute [rw] live_data
    #   Returns the live game data
    #   @api public
    #   @example
    #     feed.live_data #=> #<MLB::LiveData>
    #   @return [LiveData] the live data
    attribute :live_data, LiveData

    json do
      map "gamePk", to: :game_pk
      map "link", to: :link
      map "gameData", to: :game_data
      map "liveData", to: :live_data
    end

    # Retrieves the live feed for a game
    #
    # @api public
    # @example Get live feed for a game
    #   MLB::LiveFeed.find(game: 745571)
    # @example Get live feed using a ScheduledGame object
    #   MLB::LiveFeed.find(game: scheduled_game)
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [LiveFeed] the live feed
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/feed/live")
      from_json(response)
    end
  end
end
