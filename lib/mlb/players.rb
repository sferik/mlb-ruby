require "shale"
require_relative "player"

module MLB
  # Provides methods for fetching MLB players from the API
  class Players < Shale::Mapper
    attribute :players, Player, collection: true

    json do
      map "people", to: :players
    end

    # Retrieves all players for a given season and sport
    #
    # @api public
    # @example
    #   MLB::Players.all #=> [#<MLB::Player>, ...]
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Sport, Integer] the sport or sport ID
    # @return [Array<Player>] the list of players
    def self.all(season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      sport_id = Utils.extract_id(sport)
      response = CLIENT.get("sports/#{sport_id}/players?#{Utils.build_query(season:)}")
      from_json(response).players
    end

    # Finds a single player by ID or Player object
    #
    # @api public
    # @example
    #   MLB::Players.find(660271) #=> #<MLB::Player>
    # @param player [Player, Integer] the player or player ID
    # @return [Player, nil] the found player or nil
    def self.find(player)
      params = {personIds: Utils.extract_id(player)}
      response = CLIENT.get("people?#{Utils.build_query(params)}")
      from_json(response).players.first
    end

    # Finds multiple players by IDs or Player objects
    #
    # @api public
    # @example
    #   MLB::Players.find_all(660271, 545361) #=> [#<MLB::Player>, ...]
    # @param players [Array<Player, Integer>] the players or player IDs
    # @return [Array<Player>] the list of found players
    def self.find_all(*players)
      return all if players.empty?

      player_ids = players.map { |p| Utils.extract_id(p) }.join(",")
      response = CLIENT.get("people?#{Utils.build_query(personIds: player_ids)}")
      from_json(response).players
    end
  end
end
