require "shale"
require_relative "media_item"

module MLB
  class MediaCategory < Shale::Mapper
    attribute :title, Shale::Type::String
    attribute :items, MediaItem, collection: true
  end
end
