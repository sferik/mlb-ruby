require "equalizer"
require "shale"
require_relative "comparable_by_attribute"

module MLB
  # Represents a sport (e.g., MLB, Minor League Baseball)
  class Sport < Shale::Mapper
    include Comparable
    include ComparableByAttribute
    include Equalizer.new(:id)

    # Returns the attribute used for sorting
    #
    # @api private
    # @return [Symbol] the attribute used for comparison
    def comparable_attribute = :sort_order

    attribute :id, Shale::Type::Integer
    attribute :code, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :abbreviation, Shale::Type::String
    attribute :sort_order, Shale::Type::Integer
    attribute :active, Shale::Type::Boolean

    # Checks if the sport is active
    #
    # @api public
    # @example
    #   sport.active? #=> true
    # @return [Boolean] whether the sport is active
    def active? = active

    json do
      map "id", to: :id
      map "code", to: :code
      map "link", to: :link
      map "name", to: :name
      map "abbreviation", to: :abbreviation
      map "sortOrder", to: :sort_order
      map "activeStatus", to: :active
    end
  end
end
