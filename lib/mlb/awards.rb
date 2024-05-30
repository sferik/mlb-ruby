require "shale"
require_relative "award"

module MLB
  class Awards < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :awards, Award, collection: true

    def self.all
      response = CLIENT.get("awards")
      awards = from_json(response)
      awards.awards.sort!
    end

    def self.find(award)
      id = award.respond_to?(:id) ? award.id : award
      response = CLIENT.get("awards")
      awards = from_json(response)
      awards.awards.find { |a| a.id.eql?(id) }
    end
  end
end
