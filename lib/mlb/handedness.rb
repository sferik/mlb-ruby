require "equalizer"
require "shale"

module MLB
  class Handedness < Shale::Mapper
    include Equalizer.new(:code)

    attribute :code, Shale::Type::String
    attribute :description, Shale::Type::String

    json do
      map "code", to: :code
      map "description", to: :description
    end
  end
end
