require "equalizer"
require "shale"
require_relative "league"
require_relative "sport"

module MLB
  class Division < Shale::Mapper
    include Comparable
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :season, Shale::Type::String
    attribute :name_short, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :league, League
    attribute :sport, Sport
    attribute :has_wildcard, Shale::Type::Boolean
    attribute :sort_order, Shale::Type::Integer
    attribute :active, Shale::Type::Boolean

    alias_method :active?, :active
    alias_method :wildcard?, :has_wildcard

    json do
      map "id", to: :id
      map "name", to: :name
      map "season", to: :season
      map "nameShort", to: :name_short
      map "link", to: :link
      map "abbreviation", to: :abbreviation
      map "league", to: :league
      map "sport", to: :sport
      map "hasWildcard", to: :has_wildcard
      map "sortOrder", to: :sort_order
      map "active", to: :active
    end

    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
