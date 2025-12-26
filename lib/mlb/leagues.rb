require "shale"
require_relative "league"

module MLB
  # Collection of leagues from the MLB Stats API
  class Leagues < Shale::Mapper
    attribute :leagues, League, collection: true

    # Retrieves all leagues
    #
    # @api public
    # @example
    #   MLB::Leagues.all
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<League>] list of all leagues
    def self.all(sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("leagues?#{Utils.build_query(params)}")
      from_json(response).leagues.sort
    end

    # Finds a league by ID
    #
    # @api public
    # @example
    #   MLB::Leagues.find(103)
    # @param league [Integer, League] the league ID or League object
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [League, nil] the league if found
    def self.find(league, sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("leagues/#{Utils.extract_id(league)}?#{Utils.build_query(params)}")
      from_json(response).leagues.min_by { |l| l.sort_order || 0 }
    end
  end
end
