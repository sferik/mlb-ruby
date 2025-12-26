require_relative "../test_helper"

module MLB
  class JobsTest < Minitest::Test
    cover Jobs

    def test_self_umpires
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/umpires?season=2024")
        .to_return(body: '{"copyright":"Copyright","roster":[' \
                         '{"person":{"id":427127,"fullName":"John Tumpane"},' \
                         '"jerseyNumber":"67","job":"Umpire","jobId":"UMPR"}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      umpires = Jobs.umpires(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/umpires?season=2024"
      assert_equal 1, umpires.size
      assert_equal 427_127, umpires.first.person.id
    end

    def test_self_umpires_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/umpires?season=#{year}")
        .to_return(body: '{"copyright":"Copyright","roster":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      umpires = Jobs.umpires

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/umpires?season=#{year}"
      assert_equal 0, umpires.size
    end

    def test_self_datacasters
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/datacasters?season=2024")
        .to_return(body: '{"copyright":"Copyright","roster":[' \
                         '{"person":{"id":123456,"fullName":"Test Person"},' \
                         '"job":"Datacaster","jobId":"DCAS"}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      datacasters = Jobs.datacasters(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/datacasters?season=2024"
      assert_equal 1, datacasters.size
    end

    def test_self_datacasters_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/datacasters?season=#{year}")
        .to_return(body: '{"copyright":"Copyright","roster":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      datacasters = Jobs.datacasters

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/datacasters?season=#{year}"
      assert_equal 0, datacasters.size
    end

    def test_self_official_scorers
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/officialScorers?season=2024")
        .to_return(body: '{"copyright":"Copyright","roster":[' \
                         '{"person":{"id":789012,"fullName":"Test Scorer"},' \
                         '"job":"Official Scorer","jobId":"OFSC"}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      scorers = Jobs.official_scorers(season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/officialScorers?season=2024"
      assert_equal 1, scorers.size
    end

    def test_self_official_scorers_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/officialScorers?season=#{year}")
        .to_return(body: '{"copyright":"Copyright","roster":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      scorers = Jobs.official_scorers

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/officialScorers?season=#{year}"
      assert_equal 0, scorers.size
    end

    def test_self_umpire_games_with_umpire_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/umpires/games/427127?season=2024")
        .to_return(body: '{"copyright":"Copyright","roster":[' \
                         '{"person":{"id":427127,"fullName":"John Tumpane"},' \
                         '"job":"Umpire","jobId":"UMPR"}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Jobs.umpire_games(umpire: 427_127, season: 2024)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobs/umpires/games/427127?season=2024"
      assert_equal 1, games.size
    end

    def test_self_umpire_games_with_job_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/umpires/games/427127?season=2024")
        .to_return(body: '{"copyright":"Copyright","roster":[' \
                         '{"person":{"id":427127,"fullName":"John Tumpane"}}]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      job = Job.new(person: Player.new(id: 427_127))
      games = Jobs.umpire_games(umpire: job, season: 2024)

      assert_equal 1, games.size
    end

    def test_self_umpire_games_defaults_to_current_year
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobs/umpires/games/427127?season=#{year}")
        .to_return(body: '{"copyright":"Copyright","roster":[]}',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      games = Jobs.umpire_games(umpire: 427_127)

      assert_requested :get,
        "https://statsapi.mlb.com/api/v1/jobs/umpires/games/427127?season=#{year}"
      assert_equal 0, games.size
    end
  end
end
