require "shale"

module MLB
  # Represents a media playback option
  class MediaPlayback < Shale::Mapper
    # @!attribute [rw] name
    #   Returns the playback name
    #   @api public
    #   @example
    #     playback.name #=> "mp4Avc"
    #   @return [String] the name
    attribute :name, Shale::Type::String

    # @!attribute [rw] url
    #   Returns the playback URL
    #   @api public
    #   @example
    #     playback.url #=> "https://..."
    #   @return [String] the URL
    attribute :url, Shale::Type::String

    json do
      map "name", to: :name
      map "url", to: :url
    end
  end

  # Represents a media image cut
  class MediaCut < Shale::Mapper
    # @!attribute [rw] aspect_ratio
    #   Returns the aspect ratio
    #   @api public
    #   @example
    #     cut.aspect_ratio #=> "16:9"
    #   @return [String] the aspect ratio
    attribute :aspect_ratio, Shale::Type::String

    # @!attribute [rw] width
    #   Returns the width
    #   @api public
    #   @example
    #     cut.width #=> 1920
    #   @return [Integer] the width
    attribute :width, Shale::Type::Integer

    # @!attribute [rw] height
    #   Returns the height
    #   @api public
    #   @example
    #     cut.height #=> 1080
    #   @return [Integer] the height
    attribute :height, Shale::Type::Integer

    # @!attribute [rw] src
    #   Returns the image source URL
    #   @api public
    #   @example
    #     cut.src #=> "https://..."
    #   @return [String] the source URL
    attribute :src, Shale::Type::String

    json do
      map "aspectRatio", to: :aspect_ratio
      map "width", to: :width
      map "height", to: :height
      map "src", to: :src
    end
  end

  # Represents media image information
  class MediaImage < Shale::Mapper
    # @!attribute [rw] title
    #   Returns the image title
    #   @api public
    #   @example
    #     image.title #=> "Highlight Image"
    #   @return [String] the title
    attribute :title, Shale::Type::String

    # @!attribute [rw] cuts
    #   Returns the image cuts
    #   @api public
    #   @example
    #     image.cuts #=> [#<MLB::MediaCut>, ...]
    #   @return [Array<MediaCut>] the cuts
    attribute :cuts, MediaCut, collection: true

    json do
      map "title", to: :title
      map "cuts", to: :cuts
    end
  end

  # Represents a game highlight
  class Highlight < Shale::Mapper
    include Equalizer.new(:id, :headline)

    # @!attribute [rw] id
    #   Returns the highlight ID
    #   @api public
    #   @example
    #     highlight.id #=> "12345"
    #   @return [String] the ID
    attribute :id, Shale::Type::String

    # @!attribute [rw] type
    #   Returns the content type
    #   @api public
    #   @example
    #     highlight.type #=> "video"
    #   @return [String] the type
    attribute :type, Shale::Type::String

    # @!attribute [rw] headline
    #   Returns the headline
    #   @api public
    #   @example
    #     highlight.headline #=> "Player hits home run"
    #   @return [String] the headline
    attribute :headline, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the description
    #   @api public
    #   @example
    #     highlight.description #=> "Player crushes a 3-run homer"
    #   @return [String] the description
    attribute :description, Shale::Type::String

    # @!attribute [rw] duration
    #   Returns the duration in seconds
    #   @api public
    #   @example
    #     highlight.duration #=> "00:00:45"
    #   @return [String] the duration
    attribute :duration, Shale::Type::String

    # @!attribute [rw] playbacks
    #   Returns the playback options
    #   @api public
    #   @example
    #     highlight.playbacks #=> [#<MLB::MediaPlayback>, ...]
    #   @return [Array<MediaPlayback>] the playbacks
    attribute :playbacks, MediaPlayback, collection: true

    # @!attribute [rw] image
    #   Returns the thumbnail image
    #   @api public
    #   @example
    #     highlight.image #=> #<MLB::MediaImage>
    #   @return [MediaImage] the image
    attribute :image, MediaImage

    json do
      map "id", to: :id
      map "type", to: :type
      map "headline", to: :headline
      map "description", to: :description
      map "duration", to: :duration
      map "playbacks", to: :playbacks
      map "image", to: :image
    end
  end

  # Represents the highlights section
  class HighlightsSection < Shale::Mapper
    # @!attribute [rw] highlights
    #   Returns the highlights
    #   @api public
    #   @example
    #     section.highlights #=> [#<MLB::Highlight>, ...]
    #   @return [Array<Highlight>] the highlights
    attribute :highlights, Highlight, collection: true

    json do
      map "items", to: :highlights
    end
  end

  # Represents the game content media
  class GameContentMedia < Shale::Mapper
    # @!attribute [rw] free_game
    #   Returns whether this is a free game
    #   @api public
    #   @example
    #     media.free_game #=> true
    #   @return [Boolean] whether free game
    attribute :free_game, Shale::Type::Boolean

    # @!attribute [rw] enhanced_game
    #   Returns whether this is an enhanced game
    #   @api public
    #   @example
    #     media.enhanced_game #=> false
    #   @return [Boolean] whether enhanced game
    attribute :enhanced_game, Shale::Type::Boolean

    json do
      map "freeGame", to: :free_game
      map "enhancedGame", to: :enhanced_game
    end
  end

  # Represents the game content
  class GameContent < Shale::Mapper
    # @!attribute [rw] link
    #   Returns the API link
    #   @api public
    #   @example
    #     content.link #=> "/api/v1/game/745571/content"
    #   @return [String] the link
    attribute :link, Shale::Type::String

    # @!attribute [rw] media
    #   Returns the media info
    #   @api public
    #   @example
    #     content.media #=> #<MLB::GameContentMedia>
    #   @return [GameContentMedia] the media
    attribute :media, GameContentMedia

    # @!attribute [rw] highlights
    #   Returns the highlights
    #   @api public
    #   @example
    #     content.highlights #=> #<MLB::HighlightsSection>
    #   @return [HighlightsSection] the highlights
    attribute :highlights, HighlightsSection

    json do
      map "link", to: :link
      map "media", to: :media
      map "highlights", to: :highlights
    end

    # Retrieves the content for a game
    #
    # @api public
    # @example Get content for a game
    #   MLB::GameContent.find(game: 745571)
    # @example Get content using a ScheduledGame object
    #   MLB::GameContent.find(game: scheduled_game)
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [GameContent] the game content
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/content")
      from_json(response)
    end
  end
end
