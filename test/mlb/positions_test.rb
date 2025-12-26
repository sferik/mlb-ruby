require_relative "../test_helper"

module MLB
  class PositionsTest < Minitest::Test
    cover Positions

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/positions")
        .to_return(body: '[{"code":"1","name":"Pitcher","type":"Pitcher","abbreviation":"P"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      position = Positions.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/positions"
      assert_equal "1", position.code
      assert_equal "Pitcher", position.name
    end
  end
end
