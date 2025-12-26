require "shale"

module MLB
  # Represents a game that has been modified since a given timestamp
  class ChangedGame < Shale::Mapper
    include Equalizer.new(:game_pk)

    # @!attribute [rw] game_pk
    #   Returns the unique game identifier
    #   @api public
    #   @example
    #     game.game_pk #=> 745571
    #   @return [Integer] the game primary key
    attribute :game_pk, Shale::Type::Integer

    json do
      map "gamePk", to: :game_pk
    end
  end

  # Groups changed games by date
  class ChangedGameDate < Shale::Mapper
    # @!attribute [rw] date
    #   Returns the date string
    #   @api public
    #   @example
    #     date_entry.date #=> "2024-06-15"
    #   @return [String] the date in YYYY-MM-DD format
    attribute :date, Shale::Type::String

    # @!attribute [rw] games
    #   Returns the games that changed on this date
    #   @api public
    #   @example
    #     date_entry.games #=> [#<MLB::ChangedGame>, ...]
    #   @return [Array<ChangedGame>] the changed games
    attribute :games, ChangedGame, collection: true

    json do
      map "date", to: :date
      map "games", to: :games
    end
  end

  # Fetches games that have been modified since a given timestamp
  #
  # This endpoint is useful for efficiently polling for game updates
  # rather than fetching all game data repeatedly.
  class GameChanges < Shale::Mapper
    # @!attribute [rw] dates
    #   Returns dates containing changed games
    #   @api public
    #   @example
    #     response.dates #=> [#<MLB::ChangedGameDate>, ...]
    #   @return [Array<ChangedGameDate>] the dates with changes
    attribute :dates, ChangedGameDate, collection: true

    json do
      map "dates", to: :dates
    end

    # Retrieves games modified since the given timestamp
    #
    # @api public
    # @example Basic usage with ISO 8601 timestamp
    #   MLB::GameChanges.since(updated_since: "2024-06-15T12:00:00Z")
    # @example Filter by sport (1 = MLB)
    #   MLB::GameChanges.since(updated_since: "2024-06-15T12:00:00Z", sport_id: 1)
    # @example Filter by season and game type
    #   MLB::GameChanges.since(updated_since: timestamp, season: 2024, game_type: "R")
    # @param updated_since [#to_s] timestamp to check changes from (ISO 8601 format)
    # @param sport_id [Integer, nil] filter by sport ID
    # @param season [Integer, nil] filter by season year
    # @param game_type [String, nil] filter by game type (R=Regular, P=Postseason, etc.)
    # @return [Array<ChangedGame>] games modified since the timestamp
    def self.since(updated_since:, sport_id: nil, season: nil, game_type: nil)
      params = {
        updatedSince: updated_since.to_s,
        sportId: sport_id,
        season: season,
        gameType: game_type
      }.compact
      response = CLIENT.get("game/changes?#{URI.encode_www_form(params)}")
      from_json(response).dates.flat_map(&:games)
    end
  end
end
