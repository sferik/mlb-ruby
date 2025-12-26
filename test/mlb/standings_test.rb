require_relative "../test_helper"

module MLB
  class StandingsTest < Minitest::Test
    cover Standings

    def test_self_all_with_default_season
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=#{year}")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147},"wins":94,"losses":68}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      records = Standings.all

      assert_equal 1, records.size
    end

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147},"wins":94,"losses":68}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      records = Standings.all(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/standings?" \
                             "leagueId=103,104&season=2024"
      assert_equal 1, records.size
      assert_equal 201, records.first.division.id
    end

    def test_self_find
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147}}]},' \
                         '{"standingsType":"regularSeason","division":{"id":202},' \
                         '"teamRecords":[{"team":{"id":114}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 201, season: 2024)

      assert_equal 201, record.division.id
    end

    def test_self_find_with_division_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      division = Division.new(id: 201)
      record = Standings.find(division:, season: 2024)

      assert_equal 201, record.division.id
    end

    def test_self_find_not_found
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 999, season: 2024)

      assert_nil record
    end

    def test_self_find_with_nil_division_in_record
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason",' \
                         '"teamRecords":[{"team":{"id":147}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 201, season: 2024)

      assert_nil record
    end

    def test_self_find_with_default_season
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=#{year}")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 201)

      assert_equal 201, record.division.id
    end

    def test_self_find_with_custom_league_ids
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 201, season: 2024, league_ids: [103])

      assert_equal 201, record.division.id
    end

    def test_self_find_returns_correct_division
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[{"team":{"id":147}}]},' \
                         '{"standingsType":"regularSeason","division":{"id":202},' \
                         '"teamRecords":[{"team":{"id":114}}]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      record = Standings.find(division: 202, season: 2024)

      assert_equal 202, record.division.id
    end

    def test_self_find_with_matching_string_division_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024")
        .to_return(body: '{"copyright":"Copyright","records":[' \
                         '{"standingsType":"regularSeason","division":{"id":201},' \
                         '"teamRecords":[]}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      assert_nil Standings.find(division: "201", season: 2024)
    end
  end
end
