require "equalizer"
require "shale"
require "uri"
require_relative "league"
require_relative "sport"
require_relative "player"

module MLB
  class Award < Shale::Mapper
    include Comparable
    include Equalizer.new(:id, :player, :season)

    attribute :id, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :notes, Shale::Type::String
    attribute :votes, Shale::Type::Integer
    attribute :date, Shale::Type::Date
    attribute :season, Shale::Type::Integer
    attribute :sport, Sport
    attribute :player, Player
    attribute :league, League
    attribute :sort_order, Shale::Type::Integer

    json do
      map "id", to: :id
      map "name", to: :name
      map "sport", to: :sport
      map "league", to: :league
      map "player", to: :player
      map "sortOrder", to: :sort_order
      map "season", to: :season
      map "notes", to: :notes
      map "votes", to: :votes
    end

    def <=>(other)
      sort_order <=> other.sort_order
    end

    def recipients(season: Time.now.year)
      params = {season:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("awards/#{id}/recipients?#{query_string}")
      awards = Awards.from_json(response)
      awards.awards
    end
  end
end
