require "shale"
require "uri"
require_relative "conference"

module MLB
  class Conferences < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :conferences, Conference, collection: true

    def self.all
      response = CLIENT.get("conferences")
      conferences = from_json(response)
      conferences.conferences
    end

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
