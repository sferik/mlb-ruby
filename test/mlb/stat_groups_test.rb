require_relative "../test_helper"

module MLB
  class StatGroupsTest < Minitest::Test
    cover StatGroups

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/statGroups")
        .to_return(body: '[{"displayName":"hitting"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      stat_group = StatGroups.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/statGroups"
      assert_equal "hitting", stat_group.display_name
    end
  end
end
