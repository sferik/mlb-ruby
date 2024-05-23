require "equalizer"
require "shale"

module MLB
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

    def <=>(other)
      sort_order <=> other.sort_order
    end
  end
end
