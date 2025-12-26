require "shale"
require "uri"
require_relative "sport"
require_relative "player"

module MLB
  # Provides methods for fetching MLB players from the API
  class Players < Shale::Mapper
    # @!attribute [rw] copyright
    #   Returns the API copyright notice
    #   @api public
    #   @example
    #     players_response.copyright #=> "Copyright 2024 MLB Advanced Media..."
    #   @return [String] the API copyright notice
    attribute :copyright, Shale::Type::String

    # @!attribute [rw] players
    #   Returns the collection of players
    #   @api public
    #   @example
    #     players_response.players #=> [#<MLB::Player>, ...]
    #   @return [Array<Player>] the collection of players
    attribute :players, Player, collection: true

    json do
      map "copyright", to: :copyright
      map "people", to: :players
    end

    # Retrieves all players for a given season and sport
    #
    # @api public
    # @example
    #   MLB::Players.all #=> [#<MLB::Player>, ...]
    # @param season [Integer] the season year
    # @param sport [Sport, Integer] the sport or sport ID
    # @return [Array<Player>] the list of players
    def self.all(season: Time.now.year, sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("sports/#{sport_id}/players?#{query_string}")
      players = from_json(response)
      players.players
    end

    # Finds a single player by ID or Player object
    #
    # @api public
    # @example
    #   MLB::Players.find(660271) #=> #<MLB::Player>
    # @param player [Player, Integer] the player or player ID
    # @return [Player, nil] the found player or nil
    def self.find(player)
      player_id = player.respond_to?(:id) ? player.id : player
      params = {personIds: player_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("people?#{query_string}")
      players = from_json(response)
      players.players.first
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

      player_ids = players.map { |player| player.respond_to?(:id) ? player.id : player }.join(",")
      params = {personIds: player_ids}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("people?#{query_string}")
      players = from_json(response)
      players.players
    end
  end
end
