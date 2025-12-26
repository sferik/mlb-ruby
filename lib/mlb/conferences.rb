require "shale"
require "uri"
require_relative "conference"

module MLB
  # Collection of conferences from the MLB Stats API
  class Conferences < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :conferences, Conference, collection: true

    # Retrieves all conferences
    #
    # @api public
    # @example
    #   MLB::Conferences.all
    # @return [Array<Conference>] list of all conferences
    def self.all
      response = CLIENT.get("conferences")
      conferences = from_json(response)
      conferences.conferences
    end

    # Finds a conference by ID
    #
    # @api public
    # @example
    #   MLB::Conferences.find(301)
    # @param conference [Integer, Conference] the conference ID or Conference object
    # @return [Conference, nil] the conference if found
    def self.find(conference)
      id = conference.respond_to?(:id) ? conference.id : conference
      params = {conferenceId: id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("conferences?#{query_string}")
      conferences = from_json(response)
      conferences.conferences.first
    end
  end
end
