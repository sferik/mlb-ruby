require "shale"
require_relative "season"

module MLB
  # Collection of seasons from the MLB Stats API
  class Seasons < Shale::Mapper
    attribute :seasons, Season, collection: true

    # Retrieves all seasons
    #
    # @api public
    # @example
    #   MLB::Seasons.all
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Season>] list of all seasons
    def self.all(sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("seasons?#{Utils.build_query(params)}")
      from_json(response).seasons.sort
    end

    # Finds a season by ID
    #
    # @api public
    # @example
    #   MLB::Seasons.find(2024)
    # @param season [Integer, Season] the season ID or Season object
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Season, nil] the season if found
    def self.find(season, sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("seasons/#{Utils.extract_id(season)}?#{Utils.build_query(params)}")
      from_json(response).seasons.min_by { |s| s.id || 0 }
    end
  end
end
