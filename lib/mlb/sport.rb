require "equalizer"
require "shale"

module MLB
  # Represents a sport (e.g., MLB, Minor League Baseball)
  class Sport < Shale::Mapper
    include Comparable
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :code, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :sort_order, Shale::Type::Integer
    attribute :active, Shale::Type::Boolean

    # Returns whether the sport is active
    #
    # @api public
    # @example
    #   sport.active?
    # @return [Boolean, nil] true if the sport is active
    alias_method :active?, :active

    json do
      map "id", to: :id
      map "code", to: :code
      map "link", to: :link
      map "name", to: :name
      map "abbreviation", to: :abbreviation
      map "sortOrder", to: :sort_order
      map "activeStatus", to: :active
    end

    # Compares sports by sort order
    #
    # @api public
    # @example
    #   sport1 <=> sport2
    # @param other [Sport] the sport to compare with
    # @return [Integer, nil] -1, 0, or 1 for comparison
    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
