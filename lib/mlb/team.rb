require "equalizer"
require "shale"
require "uri"
require_relative "division"
require_relative "league"
require_relative "sport"
require_relative "venue"

module MLB
  class Team < Shale::Mapper
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :spring_league, League
    attribute :all_star_status, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :season, Shale::Type::Integer
    attribute :venue, Venue
    attribute :spring_venue, Venue
    attribute :team_code, Shale::Type::String
    attribute :file_code, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :team_name, Shale::Type::String
    attribute :location_name, Shale::Type::String
    attribute :first_year_of_play, Shale::Type::Integer
    attribute :league, League
    attribute :division, Division
    attribute :sport, Sport
    attribute :short_name, Shale::Type::String
    attribute :franchise_name, Shale::Type::String
    attribute :club_name, Shale::Type::String
    attribute :active, Shale::Type::Boolean

    alias_method :active?, :active

    json do
      map "springLeague", to: :spring_league
      map "allStarStatus", to: :all_star_status
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "season", to: :season
      map "venue", to: :venue
      map "springVenue", to: :spring_venue
      map "teamCode", to: :team_code
      map "fileCode", to: :file_code
      map "abbreviation", to: :abbreviation
      map "teamName", to: :team_name
      map "locationName", to: :location_name
      map "firstYearOfPlay", to: :first_year_of_play
      map "league", to: :league
      map "division", to: :division
      map "sport", to: :sport
      map "shortName", to: :short_name
      map "franchiseName", to: :franchise_name
      map "clubName", to: :club_name
      map "active", to: :active
    end

    def roster(season: Time.now.year)
      params = {season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("teams/#{id}/roster?#{query_string}")
      roster = Roster.from_json(response)
      roster.roster
    end
  end
end
