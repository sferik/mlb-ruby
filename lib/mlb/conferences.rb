require "shale"
require_relative "conference"

module MLB
  # Collection of conferences from the MLB Stats API
  class Conferences < Shale::Mapper
    attribute :conferences, Conference, collection: true

    # Retrieves all conferences
    #
    # @api public
    # @example
    #   MLB::Conferences.all
    # @return [Array<Conference>] list of all conferences
    def self.all
      response = CLIENT.get("conferences")
      from_json(response).conferences
    end

    # Finds a conference by ID
    #
    # @api public
    # @example
    #   MLB::Conferences.find(301)
    # @param conference [Integer, Conference] the conference ID or Conference object
    # @return [Conference, nil] the conference if found
    def self.find(conference)
      params = {conferenceId: Utils.extract_id(conference)}
      response = CLIENT.get("conferences?#{Utils.build_query(params)}")
      from_json(response).conferences.first
    end
  end
end
