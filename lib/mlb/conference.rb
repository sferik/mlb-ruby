require "equalizer"
require "shale"
require_relative "league"
require_relative "sport"

module MLB
  class Conference < Shale::Mapper
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :has_wildcard, Shale::Type::Boolean
    attribute :league, League
    attribute :sport, Sport
    attribute :name_short, Shale::Type::String

    alias_method :wildcard?, :has_wildcard

    json do
      map "id", to: :id
      map "name", to: :name
      map "link", to: :link
      map "abbreviation", to: :abbreviation
      map "hasWildcard", to: :has_wildcard
      map "league", to: :league
      map "sport", to: :sport
      map "nameShort", to: :name_short
    end
  end
end
