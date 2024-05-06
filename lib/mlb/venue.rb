require "shale"

module MLB
  class Venue < Shale::Mapper
    attribute :id, Shale::Type::Integer
    attribute :name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :active, Shale::Type::Boolean
    attribute :season, Shale::Type::Integer

    alias_method :active?, :active
  end
end
