require_relative "../test_helper"

module MLB
  class PlatformsTest < Minitest::Test
    cover Platforms

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/platforms")
        .to_return(body: '[{"platformCode":"web","platformDescription":"Web"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      platform = Platforms.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/platforms"
      assert_equal "web", platform.platform_code
      assert_equal "Web", platform.platform_description
    end
  end
end
