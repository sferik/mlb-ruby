require_relative "../test_helper"

module MLB
  class SituationCodesTest < Minitest::Test
    cover SituationCodes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/situationCodes")
        .to_return(body: '[{"code":"h","sortOrder":1,"navigationMenu":"Game",' \
                         '"description":"Home Games","team":true,"batting":true,' \
                         '"fielding":true,"pitching":true}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      situation_code = SituationCodes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/situationCodes"
      assert_equal "h", situation_code.code
      assert_equal "Home Games", situation_code.description
    end
  end
end
