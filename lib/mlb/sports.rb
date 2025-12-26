require "shale"
require_relative "sport"

module MLB
  # Collection of sports from the MLB Stats API
  class Sports < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :sports, Sport, collection: true

    # Retrieves all sports
    #
    # @api public
    # @example
    #   MLB::Sports.all
    # @return [Array<Sport>] list of all sports
    def self.all
      response = CLIENT.get("sports")
      sports = from_json(response)
      sports.sports.sort!
    end

    # Finds a sport by ID
    #
    # @api public
    # @example
    #   MLB::Sports.find(1)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Sport, nil] the sport if found
    def self.find(sport)
      id = sport.respond_to?(:id) ? sport.id : sport
      response = CLIENT.get("sports/#{id}")
      sports = from_json(response)
      sports.sports.sort!.first
    end
  end
end
