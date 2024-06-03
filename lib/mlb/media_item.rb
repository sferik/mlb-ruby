require "equalizer"
require "shale"

module MLB
  class MediaItem < Shale::Mapper
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :content_id, Shale::Type::String
    attribute :media_id, Shale::Type::String
    attribute :media_state, Shale::Type::String
    attribute :media_feed_type, Shale::Type::String
    attribute :media_feed_subtype, Shale::Type::Integer
    attribute :call_letters, Shale::Type::String
    attribute :fox_auth_required, Shale::Type::Boolean
    attribute :tbs_auth_required, Shale::Type::Boolean
    attribute :espn_auth_required, Shale::Type::Boolean
    attribute :fs1_auth_required, Shale::Type::Boolean
    attribute :mlbn_auth_required, Shale::Type::Boolean
    attribute :free_game, Shale::Type::Boolean
    attribute :description, Shale::Type::String
    attribute :rendition_name, Shale::Type::String
    attribute :language, Shale::Type::String

    alias_method :fox_auth_required?, :fox_auth_required
    alias_method :tbs_auth_required?, :tbs_auth_required
    alias_method :espn_auth_required?, :espn_auth_required
    alias_method :fs1_auth_required?, :fs1_auth_required
    alias_method :mlbn_auth_required?, :mlbn_auth_required
    alias_method :free_game?, :free_game

    json do
      map "id", to: :id
      map "contentId", to: :content_id
      map "mediaId", to: :media_id
      map "mediaState", to: :media_state
      map "mediaFeedType", to: :media_feed_type
      map "mediaFeedSubType", to: :media_feed_subtype
      map "callLetters", to: :call_letters
      map "foxAuthRequired", to: :fox_auth_required
      map "tbsAuthRequired", to: :tbs_auth_required
      map "espnAuthRequired", to: :espn_auth_required
      map "fs1AuthRequired", to: :fs1_auth_required
      map "mlbnAuthRequired", to: :mlbn_auth_required
      map "freeGame", to: :free_game
      map "description", to: :description
      map "renditionName", to: :rendition_name
      map "language", to: :language
    end
  end
end
