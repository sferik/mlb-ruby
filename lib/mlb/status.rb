require "shale"

module MLB
  class Status < Shale::Mapper
    include Equalizer.new(:code)

    attribute :code, Shale::Type::String
    attribute :description, Shale::Type::String
  end
end
