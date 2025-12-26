require_relative "../test_helper"

module MLB
  class DraftTest < Minitest::Test
    cover Draft

    def test_self_picks
      stub_request(:get, "https://statsapi.mlb.com/api/v1/draft/2024")
        .to_return(body: draft_json, headers: json_headers)
      picks = Draft.picks(year: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/draft/2024"
      assert_equal 2, picks.size
      assert_equal 1, picks.first.pick_number
      assert_equal 683_953, picks.first.person.id
    end

    def test_self_picks_with_empty_response
      stub_request(:get, "https://statsapi.mlb.com/api/v1/draft/1900")
        .to_return(body: '{"drafts":null}', headers: json_headers)
      picks = Draft.picks(year: 1900)

      assert_equal 0, picks.size
    end

    def test_self_picks_defaults_to_current_year
      current_year = Utils.current_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/draft/#{current_year}")
        .to_return(body: draft_json, headers: json_headers)
      picks = Draft.picks

      assert_requested :get, "https://statsapi.mlb.com/api/v1/draft/#{current_year}"
      assert_equal 2, picks.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def draft_json
      '{"copyright":"Copyright","drafts":{"draftYear":2024,"rounds":[' \
        '{"round":"1","picks":[' \
        '{"pickRound":"1","pickNumber":1,"roundPickNumber":1,"rank":1,' \
        '"pickValue":"10570600","signingBonus":"8950000",' \
        '"person":{"id":683953,"fullName":"Travis Bazzana"},' \
        '"team":{"id":114,"name":"Cleveland Guardians"},' \
        '"school":{"name":"Oregon State","schoolClass":"4YR JR"}},' \
        '{"pickRound":"1","pickNumber":2,"roundPickNumber":2,' \
        '"person":{"id":683954,"fullName":"Charlie Condon"},' \
        '"team":{"id":136,"name":"Colorado Rockies"}}]}]}}'
    end
  end

  class DraftPickTest < Minitest::Test
    cover DraftPick

    def test_equality
      pick1 = DraftPick.new(pick_number: 1, person: Player.new(id: 123))
      pick2 = DraftPick.new(pick_number: 1, person: Player.new(id: 123))

      assert_equal pick1, pick2
    end

    def test_inequality
      pick1 = DraftPick.new(pick_number: 1, person: Player.new(id: 123))
      pick2 = DraftPick.new(pick_number: 2, person: Player.new(id: 456))

      refute_equal pick1, pick2
    end
  end
end
