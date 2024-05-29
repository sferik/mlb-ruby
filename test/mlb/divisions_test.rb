require_relative "../test_helper"

module MLB
  class DivisionsTest < Minitest::Test
    cover Divisions

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions?sportId=1")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions?sportId=1"
      assert_equal 1, division.id
    end

    def test_self_all_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions?sportId=1")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.all(sport: 1).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions?sportId=1"
      assert_equal 1, division.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(Division.new(id: 1))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1"
      assert_equal 1, division.id
    end

    def test_self_find_with_division_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1"
      assert_equal 1, division.id
    end

    def test_self_find_with_sport_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(Division.new(id: 1), sport: 1)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/1?sportId=1"
      assert_equal 1, division.id
    end
  end
end
