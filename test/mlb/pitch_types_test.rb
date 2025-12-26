require_relative "../test_helper"

module MLB
  class PitchTypesTest < Minitest::Test
    cover PitchTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/pitchTypes")
        .to_return(body: '[{"code":"FF","description":"Four-Seam Fastball"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      pitch_type = PitchTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/pitchTypes"
      assert_equal "FF", pitch_type.code
      assert_equal "Four-Seam Fastball", pitch_type.description
    end
  end
end
