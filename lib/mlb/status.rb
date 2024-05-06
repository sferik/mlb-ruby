require "shale"

module MLB
  class Status < Shale::Mapper
    attribute :code, Shale::Type::String
    attribute :description, Shale::Type::String
  end
end
