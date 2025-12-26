require_relative "../test_helper"

module MLB
  class AwardsTest < Minitest::Test
    cover Awards

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/awards")
        .to_return(body: '{"awards":[{"id":"ALAS","sortOrder":2},{"id":"MLBHOF","sortOrder":1},{"id":"NLAS","sortOrder":3}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      award = Awards.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/awards"
      assert_equal "MLBHOF", award.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/awards")
        .to_return(body: '{"awards":[{"id":"ALAS","sortOrder":2},{"id":"MLBHOF","sortOrder":1},{"id":"NLAS","sortOrder":3}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      award = Awards.find(Award.new(id: "MLBHOF"))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/awards"
      assert_equal "MLBHOF", award.id
    end

    def test_self_find_with_award_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/awards")
        .to_return(body: '{"awards":[{"id":"ALAS","sortOrder":2},{"id":"MLBHOF","sortOrder":1},{"id":"NLAS","sortOrder":3}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      award = Awards.find("MLBHOF")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/awards"
      assert_equal "MLBHOF", award.id
    end

    def test_self_find_not_found
      stub_request(:get, "https://statsapi.mlb.com/api/v1/awards")
        .to_return(body: '{"awards":[{"id":"ALAS","sortOrder":2},{"id":"MLBHOF","sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      award = Awards.find("NONEXISTENT")

      assert_requested :get, "https://statsapi.mlb.com/api/v1/awards"
      assert_nil award
    end
  end
end
