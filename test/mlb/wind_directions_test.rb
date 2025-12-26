require_relative "../test_helper"

module MLB
  class WindDirectionsTest < Minitest::Test
    cover WindDirections

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/windDirection")
        .to_return(body: '[{"code":"In From CF","description":"In From CF"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      wind_direction = WindDirections.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/windDirection"
      assert_equal "In From CF", wind_direction.code
      assert_equal "In From CF", wind_direction.description
    end
  end
end
