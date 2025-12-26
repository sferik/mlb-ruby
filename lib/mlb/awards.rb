require "shale"
require_relative "award"

module MLB
  # Provides methods for fetching MLB awards from the API
  class Awards < Shale::Mapper
    # @!attribute [rw] copyright
    #   Returns the API copyright notice
    #   @api public
    #   @example
    #     awards_response.copyright #=> "Copyright 2024 MLB Advanced Media..."
    #   @return [String] the API copyright notice
    attribute :copyright, Shale::Type::String

    # @!attribute [rw] awards
    #   Returns the collection of awards
    #   @api public
    #   @example
    #     awards_response.awards #=> [#<MLB::Award>, ...]
    #   @return [Array<Award>] the collection of awards
    attribute :awards, Award, collection: true

    # Retrieves all awards
    #
    # @api public
    # @example
    #   MLB::Awards.all #=> [#<MLB::Award>, ...]
    # @return [Array<Award>] the sorted list of awards
    def self.all
      response = CLIENT.get("awards")
      awards = from_json(response)
      awards.awards.sort!
    end

    # Finds a single award by ID or Award object
    #
    # @api public
    # @example
    #   MLB::Awards.find("MLBHOF") #=> #<MLB::Award>
    # @param award [Award, String] the award or award ID
    # @return [Award, nil] the found award or nil
    def self.find(award)
      id = award.respond_to?(:id) ? award.id : award
      response = CLIENT.get("awards")
      awards = from_json(response)
      awards.awards.find { |a| a.id.eql?(id) }
    end
  end
end
