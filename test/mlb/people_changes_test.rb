require_relative "../test_helper"

module MLB
  class PeopleChangesTest < Minitest::Test
    cover PeopleChanges

    def test_self_since
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/changes?updatedSince=2024-06-01")
        .to_return(body: people_changes_json, headers: json_headers)
      people = PeopleChanges.since(date: Date.new(2024, 6, 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/people/changes?updatedSince=2024-06-01"
      assert_equal 2, people.size
      assert_equal 837_342, people.first.id
    end

    def test_self_since_calls_to_s_on_date
      stub_request(:get, "https://statsapi.mlb.com/api/v1/people/changes?updatedSince=custom-date-format")
        .to_return(body: '{"copyright":"Copyright","people":[]}', headers: json_headers)
      date = Minitest::Mock.new
      date.expect(:to_s, "custom-date-format")
      PeopleChanges.since(date:)

      assert_mock date
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def people_changes_json
      '{"copyright":"Copyright","people":[' \
        '{"id":837342,"fullName":"Kynan Jones",' \
        '"primaryPosition":{"code":"1","name":"Pitcher"}},' \
        '{"id":699625,"fullName":"Jimmy Crooks",' \
        '"primaryPosition":{"code":"2","name":"Catcher"}}]}'
    end
  end
end
