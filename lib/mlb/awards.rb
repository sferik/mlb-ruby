require "shale"
require_relative "award"

module MLB
  # Provides methods for fetching MLB awards from the API
  class Awards < Shale::Mapper
    attribute :awards, Award, collection: true

    # Retrieves all awards
    #
    # @api public
    # @example
    #   MLB::Awards.all #=> [#<MLB::Award>, ...]
    # @return [Array<Award>] the sorted list of awards
    def self.all
      response = CLIENT.get("awards")
      from_json(response).awards.sort
    end

    # Finds a single award by ID or Award object
    #
    # @api public
    # @example
    #   MLB::Awards.find("MLBHOF") #=> #<MLB::Award>
    # @param award [Award, String] the award or award ID
    # @return [Award, nil] the found award or nil
    def self.find(award)
      target_id = Utils.extract_id(award)
      all.find { |a| a.id.eql?(target_id) }
    end
  end
end
