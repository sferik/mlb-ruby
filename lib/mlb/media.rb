require "shale"
require_relative "media_category"

module MLB
  class Media
    include Shale::Model

    attribute :epg, MediaCategory, collection: true
    attribute :milestones, Shale::Type::Boolean
    attribute :free_game, Shale::Type::Boolean
    attribute :enhanced_game, Shale::Type::Boolean

    json do
      map 'epg', to: :epg
      map 'milestones', to: :milestones
      map 'freeGame', to: :free_game
      map 'enhancedGame', to: :enhanced_game
    end
  end
end
