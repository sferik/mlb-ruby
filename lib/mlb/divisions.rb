require "shale"
require_relative "division"

module MLB
  # Collection of divisions from the MLB Stats API
  class Divisions < Shale::Mapper
    attribute :divisions, Division, collection: true

    # Retrieves all divisions
    #
    # @api public
    # @example
    #   MLB::Divisions.all
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Division>] list of all divisions
    def self.all(sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("divisions?#{Utils.build_query(params)}")
      from_json(response).divisions.sort
    end

    # Finds a division by ID
    #
    # @api public
    # @example
    #   MLB::Divisions.find(201)
    # @param division [Integer, Division] the division ID or Division object
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Division, nil] the division if found
    def self.find(division, sport: Utils::DEFAULT_SPORT_ID)
      params = {sportId: Utils.extract_id(sport)}
      response = CLIENT.get("divisions/#{Utils.extract_id(division)}?#{Utils.build_query(params)}")
      from_json(response).divisions.min_by { |d| d.sort_order || 0 }
    end
  end
end
