require_relative "../test_helper"

module MLB
  class SkiesTest < Minitest::Test
    cover Skies

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/sky")
        .to_return(body: '[{"code":"Clear","description":"Clear"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      sky = Skies.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/sky"
      assert_equal "Clear", sky.code
      assert_equal "Clear", sky.description
    end
  end
end
