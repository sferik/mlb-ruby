require "equalizer"
require "shale"
require_relative "comparable_by_attribute"
require_relative "league"
require_relative "sport"

module MLB
  # Represents a division (e.g., AL East, NL West)
  class Division < Shale::Mapper
    include Comparable
    include ComparableByAttribute
    include Equalizer.new(:id)

    # Returns the attribute used for sorting
    #
    # @api private
    # @return [Symbol] the attribute used for comparison
    def comparable_attribute = :sort_order

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

    # Checks if the division is active
    #
    # @api public
    # @example
    #   division.active? #=> true
    # @return [Boolean] whether the division is active
    def active? = active

    # Checks if the division has a wildcard
    #
    # @api public
    # @example
    #   division.wildcard? #=> true
    # @return [Boolean] whether the division has a wildcard
    def wildcard? = has_wildcard

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
  end
end
