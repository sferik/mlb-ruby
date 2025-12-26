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
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions?sportId=11")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.all(sport: 11).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions?sportId=11"
      assert_equal 1, division.id
    end

    def test_self_all_with_sport_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions?sportId=11")
        .to_return(body: '{"divisions":[{"id":2,"sortOrder":2},{"id":1,"sortOrder":1}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.all(sport: Sport.new(id: 11)).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions?sportId=11"
      assert_equal 1, division.id
    end

    def test_self_find
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1")
        .to_return(body: '{"divisions":[{"id":203,"sortOrder":3},{"id":201,"sortOrder":1},{"id":202,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(Division.new(id: 201))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1"
      assert_equal 201, division.id
      assert_equal 1, division.sort_order
    end

    def test_self_find_with_division_id
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1")
        .to_return(body: '{"divisions":[{"id":203,"sortOrder":3},{"id":201,"sortOrder":1},{"id":202,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(201)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1"
      assert_equal 201, division.id
      assert_equal 1, division.sort_order
    end

    def test_self_find_with_nil_sort_order
      # First element has sortOrder 1, second has nil sortOrder
      # With || 0: [1, 0] - 0 < 1, min_by returns second (nil record, id 200)
      # With || 1: [1, 1] - tie, min_by returns first (sortOrder=1 record, id 201)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/200?sportId=1")
        .to_return(body: '{"divisions":[{"id":201,"sortOrder":1},{"id":200}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(200)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/200?sportId=1"
      # With || 0: 0 < 1, returns second (id 200 with nil sortOrder)
      assert_equal 200, division.id
      assert_nil division.sort_order
    end

    def test_self_find_with_nil_and_zero_sort_order
      # First element has sortOrder 0, second has nil sortOrder
      # With || 0: [0, 0] - tie, min_by returns first (sortOrder=0 record, id 201)
      # With || -1: [0, -1] - -1 < 0, min_by returns second (nil record, id 200)
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1")
        .to_return(body: '{"divisions":[{"id":201,"sortOrder":0},{"id":200}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(201)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=1"
      # With || 0: tie returns first (id 201 with sortOrder 0)
      assert_equal 201, division.id
      assert_equal 0, division.sort_order
    end

    def test_self_find_with_sport_id
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=11")
        .to_return(body: '{"divisions":[{"id":203,"sortOrder":3},{"id":201,"sortOrder":1},{"id":202,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(Division.new(id: 201), sport: 11)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=11"
      assert_equal 201, division.id
      assert_equal 1, division.sort_order
    end

    def test_self_find_with_sport_object
      # Middle element has lowest sortOrder - NOT first, NOT last
      stub_request(:get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=11")
        .to_return(body: '{"divisions":[{"id":203,"sortOrder":3},{"id":201,"sortOrder":1},{"id":202,"sortOrder":2}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Divisions.find(201, sport: Sport.new(id: 11))

      assert_requested :get, "https://statsapi.mlb.com/api/v1/divisions/201?sportId=11"
      assert_equal 201, division.id
      assert_equal 1, division.sort_order
    end
  end
end
