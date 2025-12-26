require "shale"
require_relative "sport"

module MLB
  # Collection of sports from the MLB Stats API
  class Sports < Shale::Mapper
    attribute :sports, Sport, collection: true

    # Retrieves all sports
    #
    # @api public
    # @example
    #   MLB::Sports.all
    # @return [Array<Sport>] list of all sports
    def self.all
      response = CLIENT.get("sports")
      from_json(response).sports.sort
    end

    # Finds a sport by ID
    #
    # @api public
    # @example
    #   MLB::Sports.find(1)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Sport, nil] the sport if found
    def self.find(sport)
      response = CLIENT.get("sports/#{Utils.extract_id(sport)}")
      from_json(response).sports.min_by { |s| s.sort_order || 0 }
    end
  end
end
