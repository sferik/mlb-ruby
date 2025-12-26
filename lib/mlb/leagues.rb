require "shale"
require "uri"
require_relative "sport"
require_relative "league"

module MLB
  # Collection of leagues from the MLB Stats API
  class Leagues < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :leagues, League, collection: true

    # Retrieves all leagues
    #
    # @api public
    # @example
    #   MLB::Leagues.all
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<League>] list of all leagues
    def self.all(sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("leagues?#{query_string}")
      leagues = from_json(response)
      leagues.leagues.sort!
    end

    # Finds a league by ID
    #
    # @api public
    # @example
    #   MLB::Leagues.find(103)
    # @param league [Integer, League] the league ID or League object
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [League, nil] the league if found
    def self.find(league, sport: Sport.new(id: 1))
      id = league.respond_to?(:id) ? league.id : league
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("leagues/#{id}?#{query_string}")
      leagues = from_json(response)
      leagues.leagues.sort!.first
    end
  end
end
