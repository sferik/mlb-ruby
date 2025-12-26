require "shale"
require "uri"
require_relative "roster_entry"
require_relative "sport"
require_relative "team"

module MLB
  # Provides methods for fetching team rosters from the API
  class Roster < Shale::Mapper
    # @!attribute [rw] copyright
    #   Returns the API copyright notice
    #   @api public
    #   @example
    #     roster_response.copyright #=> "Copyright 2024 MLB Advanced Media..."
    #   @return [String] the API copyright notice
    attribute :copyright, Shale::Type::String

    # @!attribute [rw] roster
    #   Returns the collection of roster entries
    #   @api public
    #   @example
    #     roster_response.roster #=> [#<MLB::RosterEntry>, ...]
    #   @return [Array<RosterEntry>] the collection of roster entries
    attribute :roster, RosterEntry, collection: true

    # Finds a team's roster for a given season and sport
    #
    # @api public
    # @example
    #   MLB::Roster.find(team: 119) #=> [#<MLB::RosterEntry>, ...]
    # @param team [Team, Integer] the team or team ID
    # @param season [Integer] the season year
    # @param sport [Sport, Integer] the sport or sport ID
    # @return [Array<RosterEntry>] the list of roster entries
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
