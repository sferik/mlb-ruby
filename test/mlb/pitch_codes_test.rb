require_relative "../test_helper"

module MLB
  class PitchCodesTest < Minitest::Test
    cover PitchCodes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/pitchCodes")
        .to_return(body: '[{"code":"B","description":"Ball","swingStatus":false,"strikeStatus":false,"ballStatus":true,"sortOrder":1}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      pitch_code = PitchCodes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/pitchCodes"
      assert_equal "B", pitch_code.code
      assert_equal "Ball", pitch_code.description
    end
  end
end
