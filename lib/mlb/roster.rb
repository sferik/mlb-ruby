require "shale"
require "uri"
require_relative "roster_entry"
require_relative "sport"
require_relative "team"

module MLB
  class Roster < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :roster, RosterEntry, collection: true

    def self.find(team:, season: Time.now.year, sport: Sport.new(id: 1))
      team_id = team.respond_to?(:id) ? team.id : team
      sport_id = sport.respond_to?(:id) ? sport.id : sport
      params = {season:, sportId: sport_id}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("teams/#{team_id}/roster?#{query_string}")
      roster = from_json(response)
      roster.roster
    end
  end
end
