require_relative "../test_helper"

module MLB
  class LogicalEventsTest < Minitest::Test
    cover LogicalEvents

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/logicalEvents")
        .to_return(body: '[{"code":"countChange"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      logical_event = LogicalEvents.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/logicalEvents"
      assert_equal "countChange", logical_event.code
    end
  end
end
