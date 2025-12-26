require_relative "../test_helper"

module MLB
  class GameContentTest < Minitest::Test
    cover GameContent

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/content")
        .to_return(body: game_content_json, headers: json_headers)
      content = GameContent.find(game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745571/content"
      assert_equal "/api/v1/game/745571/content", content.link
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/content")
        .to_return(body: game_content_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      content = GameContent.find(game:)

      assert_equal "/api/v1/game/745571/content", content.link
    end

    def test_media_info
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/content")
        .to_return(body: game_content_json, headers: json_headers)
      content = GameContent.find(game: 745_571)

      assert content.media.free_game
      refute content.media.enhanced_game
    end

    def test_highlights
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/content")
        .to_return(body: game_content_json, headers: json_headers)
      content = GameContent.find(game: 745_571)
      highlight = content.highlights.highlights.first

      assert_equal "12345", highlight.id
      assert_equal "video", highlight.type
      assert_equal "Great play", highlight.headline
    end

    def test_highlight_playbacks
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745571/content")
        .to_return(body: game_content_json, headers: json_headers)
      content = GameContent.find(game: 745_571)
      playback = content.highlights.highlights.first.playbacks.first

      assert_equal "mp4Avc", playback.name
      assert_equal "https://example.com/video.mp4", playback.url
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def game_content_json
      '{"copyright":"Copyright","link":"/api/v1/game/745571/content",' \
        '"media":{"freeGame":true,"enhancedGame":false},' \
        '"highlights":{"items":[{"id":"12345","type":"video",' \
        '"headline":"Great play","description":"Amazing catch",' \
        '"duration":"00:00:30",' \
        '"playbacks":[{"name":"mp4Avc","url":"https://example.com/video.mp4"}],' \
        '"image":{"title":"Thumbnail","cuts":[{"aspectRatio":"16:9",' \
        '"width":1920,"height":1080,"src":"https://example.com/img.jpg"}]}}]}}'
    end
  end

  class HighlightTest < Minitest::Test
    cover Highlight

    def test_equality
      h1 = Highlight.new(id: "123", headline: "Test")
      h2 = Highlight.new(id: "123", headline: "Test")

      assert_equal h1, h2
    end

    def test_inequality
      h1 = Highlight.new(id: "123", headline: "Test")
      h2 = Highlight.new(id: "456", headline: "Other")

      refute_equal h1, h2
    end

    def test_description_and_duration
      highlight = Highlight.new(description: "Amazing play", duration: "00:00:45")

      assert_equal "Amazing play", highlight.description
      assert_equal "00:00:45", highlight.duration
    end

    def test_image
      cut = MediaCut.new(aspect_ratio: "16:9", width: 1920, height: 1080, src: "url")
      image = MediaImage.new(title: "Thumb", cuts: [cut])
      highlight = Highlight.new(image:)

      assert_equal "Thumb", highlight.image.title
    end
  end

  class MediaPlaybackTest < Minitest::Test
    cover MediaPlayback
  end

  class MediaCutTest < Minitest::Test
    cover MediaCut
  end

  class MediaImageTest < Minitest::Test
    cover MediaImage
  end

  class HighlightsSectionTest < Minitest::Test
    cover HighlightsSection
  end

  class GameContentMediaTest < Minitest::Test
    cover GameContentMedia
  end
end
