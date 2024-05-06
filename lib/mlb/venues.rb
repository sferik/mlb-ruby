require "shale"
require "uri"
require_relative "sport"
require_relative "venue"

module MLB
  class Venues < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :venues, Venue, collection: true

    def self.all(season: Time.now.year, sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id, season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("venues?#{query_string}")
      venues = from_json(response)
      venues.venues
    end

    def self.find(venue, season: Time.now.year, sport: Sport.new(id: 1))
      id = venue.respond_to?(:id) ? venue.id : venue
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id, season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("venues/#{id}?#{query_string}")
      venues = from_json(response)
      venues.venues.first
    end
  end
end
