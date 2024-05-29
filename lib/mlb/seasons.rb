require "shale"
require "uri"
require_relative "sport"
require_relative "season"

module MLB
  class Seasons < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :seasons, Season, collection: true

    def self.all(sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("seasons?#{query_string}")
      seasons = from_json(response)
      seasons.seasons.sort!
    end

    def self.find(season, sport: Sport.new(id: 1))
      id = season.respond_to?(:id) ? season.id : season
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("seasons/#{id}?#{query_string}")
      seasons = from_json(response)
      seasons.seasons.sort!.first
    end
  end
end
