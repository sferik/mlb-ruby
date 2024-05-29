require_relative "../test_helper"

module MLB
  class ConferencesTest < Minitest::Test
    cover Conferences

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/conferences")
        .to_return(body: '{"conferences":[{"id":301},{"id":302}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      conference = Conferences.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/conferences"
      assert_equal 301, conference.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/conferences?conferenceId=301")
        .to_return(body: '{"conferences":[{"id":301},{"id":302}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      conference = Conferences.find(Conference.new(id: 301))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/conferences?conferenceId=301"
      assert_equal 301, conference.id
    end

    def test_self_find_with_conference_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/conferences?conferenceId=301")
        .to_return(body: '{"conferences":[{"id":301},{"id":302}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      conference = Conferences.find(301)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/conferences?conferenceId=301"
      assert_equal 301, conference.id
    end
  end
end
