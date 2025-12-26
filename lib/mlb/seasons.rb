require "shale"
require "uri"
require_relative "sport"
require_relative "season"

module MLB
  # Collection of seasons from the MLB Stats API
  class Seasons < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :seasons, Season, collection: true

    # Retrieves all seasons
    #
    # @api public
    # @example
    #   MLB::Seasons.all
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Season>] list of all seasons
    def self.all(sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("seasons?#{query_string}")
      seasons = from_json(response)
      seasons.seasons.sort!
    end

    # Finds a season by ID
    #
    # @api public
    # @example
    #   MLB::Seasons.find(2024)
    # @param season [Integer, Season] the season ID or Season object
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Season, nil] the season if found
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
