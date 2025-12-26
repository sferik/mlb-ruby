require "shale"
require_relative "venue"

module MLB
  # Collection of venues from the MLB Stats API
  class Venues < Shale::Mapper
    attribute :venues, Venue, collection: true

    # Retrieves all venues
    #
    # @api public
    # @example
    #   MLB::Venues.all
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Venue>] list of all venues
    def self.all(season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {sportId: Utils.extract_id(sport), season:}
      response = CLIENT.get("venues?#{Utils.build_query(params)}")
      from_json(response).venues
    end

    # Finds a venue by ID
    #
    # @api public
    # @example
    #   MLB::Venues.find(15)
    # @param venue [Integer, Venue] the venue ID or Venue object
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Venue, nil] the venue if found
    def self.find(venue, season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {sportId: Utils.extract_id(sport), season:}
      response = CLIENT.get("venues/#{Utils.extract_id(venue)}?#{Utils.build_query(params)}")
      from_json(response).venues.first
    end
  end
end
