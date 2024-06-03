require "equalizer"
require "shale"

module MLB
  class Position < Shale::Mapper
    include Equalizer.new(:code)

    attribute :code, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :abbreviation, Shale::Type::String

    json do
      map "code", to: :code
      map "name", to: :name
      map "type", to: :type
      map "abbreviation", to: :abbreviation
    end
  end
end
