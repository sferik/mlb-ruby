require "shale"
require "uri"
require_relative "sport"
require_relative "league"

module MLB
  class Leagues < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :leagues, League, collection: true

    def self.all(sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("leagues?#{query_string}")
      leagues = from_json(response)
      leagues.leagues.sort!
    end

    def self.find(league, sport: Sport.new(id: 1))
      id = league.respond_to?(:id) ? league.id : league
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("leagues/#{id}?#{query_string}")
      leagues = from_json(response)
      leagues.leagues.first
    end
  end
end
