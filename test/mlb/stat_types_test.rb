require_relative "../test_helper"

module MLB
  class StatTypesTest < Minitest::Test
    cover StatTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/statTypes")
        .to_return(body: '[{"displayName":"season"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      stat_type = StatTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/statTypes"
      assert_equal "season", stat_type.display_name
    end
  end
end
