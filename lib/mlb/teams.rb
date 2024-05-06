require "shale"
require "uri"
require_relative "sport"
require_relative "team"

module MLB
  class Teams < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :teams, Team, collection: true

    def self.all(season: Time.now.year, sport: Sport.new(id: 1))
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id, season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("teams?#{query_string}")
      teams = from_json(response)
      teams.teams
    end

    def self.find(team, season: Time.now.year, sport: Sport.new(id: 1))
      id = team.respond_to?(:id) ? team.id : team
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {sportId: sport_id, season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("teams/#{id}?#{query_string}")
      teams = from_json(response)
      teams.teams.first
    end
  end
end
