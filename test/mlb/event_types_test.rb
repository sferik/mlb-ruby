require_relative "../test_helper"

module MLB
  class EventTypesTest < Minitest::Test
    cover EventTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/eventTypes")
        .to_return(body: '[{"code":"single","description":"Single","plateAppearance":true,"hit":true,"baseRunningEvent":false}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      event_type = EventTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/eventTypes"
      assert_equal "single", event_type.code
      assert_predicate event_type, :hit?
    end
  end
end
