require "shale"
require "uri"
require_relative "sport"
require_relative "player"

module MLB
  class Players < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :players, Player, collection: true

    json do
      map "copyright", to: :copyright
      map "people", to: :players
    end

    def self.all(season: Time.now.year, sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("sports/#{sport_id}/players?#{query_string}")
      players = from_json(response)
      players.players
    end

    def self.find(player)
      player_id = player.respond_to?(:id) ? player.id : player
      params = {personIds: player_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("people?#{query_string}")
      players = from_json(response)
      players.players.first
    end

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
