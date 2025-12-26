require_relative "../test_helper"

module MLB
  class ScheduleEventTypesTest < Minitest::Test
    cover ScheduleEventTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/scheduleEventTypes")
        .to_return(body: '[{"code":"P","name":"Postseason Game"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      schedule_event_type = ScheduleEventTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/scheduleEventTypes"
      assert_equal "P", schedule_event_type.code
      assert_equal "Postseason Game", schedule_event_type.name
    end
  end
end
