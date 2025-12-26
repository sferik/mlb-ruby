require "shale"
require "uri"
require_relative "sport"
require_relative "venue"

module MLB
  # Collection of venues from the MLB Stats API
  class Venues < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :venues, Venue, collection: true

    # Retrieves all venues
    #
    # @api public
    # @example
    #   MLB::Venues.all
    # @param season [Integer] the season year
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Venue>] list of all venues
    def self.all(season: Time.now.year, sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id, season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("venues?#{query_string}")
      venues = from_json(response)
      venues.venues
    end

    # Finds a venue by ID
    #
    # @api public
    # @example
    #   MLB::Venues.find(15)
    # @param venue [Integer, Venue] the venue ID or Venue object
    # @param season [Integer] the season year
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Venue, nil] the venue if found
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
