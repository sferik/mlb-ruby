require "shale"
require "uri"
require_relative "sport"
require_relative "division"

module MLB
  class Divisions < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :divisions, Division, collection: true

    def self.all(sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("divisions?#{query_string}")
      divisions = from_json(response)
      divisions.divisions.sort!
    end

    def self.find(division, sport: Sport.new(id: 1))
      id = division.respond_to?(:id) ? division.id : division
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("divisions/#{id}?#{query_string}")
      divisions = from_json(response)
      divisions.divisions.sort!.first
    end
  end
end
