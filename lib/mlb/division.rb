require "equalizer"
require "shale"
require_relative "league"
require_relative "sport"

module MLB
  # Represents a division (e.g., AL East, NL West)
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

    # Returns whether the division is active
    #
    # @api public
    # @example
    #   division.active?
    # @return [Boolean, nil] true if the division is active
    alias_method :active?, :active

    # Returns whether the division has a wild card
    #
    # @api public
    # @example
    #   division.wildcard?
    # @return [Boolean, nil] true if the division has a wild card
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

    # Compares divisions by sort order
    #
    # @api public
    # @example
    #   division1 <=> division2
    # @param other [Division] the division to compare with
    # @return [Integer, nil] -1, 0, or 1 for comparison
    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
