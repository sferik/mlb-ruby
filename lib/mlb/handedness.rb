require "shale"

module MLB
  class Handedness < Shale::Mapper
    attribute :code, Shale::Type::String
    attribute :description, Shale::Type::String

    json do
      map "code", to: :code
      map "description", to: :description
    end
  end
end
