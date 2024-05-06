require "shale"
require_relative "sport"

module MLB
  class Sports < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :sports, Sport, collection: true

    def self.all
      response = CLIENT.get("sports")
      sports = from_json(response)
      sports.sports.sort!
    end

    def self.find(sport)
      id = sport.respond_to?(:id) ? sport.id : sport
      response = CLIENT.get("sports/#{id}")
      sports = from_json(response)
      sports.sports.first
    end
  end
end
