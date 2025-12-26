require_relative "../test_helper"

module MLB
  class RosterTypesTest < Minitest::Test
    cover RosterTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/rosterTypes")
        .to_return(body: '[{"description":"40-Man Roster","lookupName":"40Man","parameter":"40Man"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      roster_type = RosterTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/rosterTypes"
      assert_equal "40Man", roster_type.parameter
      assert_equal "40-Man Roster", roster_type.description
    end
  end
end
