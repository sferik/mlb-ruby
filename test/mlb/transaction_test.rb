require_relative "../test_helper"

module MLB
  class TransactionTest < Minitest::Test
    cover Transaction

    def test_self_all
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.transaction_all.bam?sport_code='mlb'&start_date=20240504&end_date=20240504")
        .to_return(body: '{"transaction_all":{"queryResults":{"row":[{"team_id":"139","player_id":"642350"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      transaction = Transaction.all(start_date: Date.parse("2024-05-04"), end_date: Date.parse("2024-05-04")).first

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.transaction_all.bam?sport_code='mlb'&start_date=20240504&end_date=20240504"
      assert_equal "139", transaction.team_id
      assert_equal "642350", transaction.player_id
    end

    def test_team
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season='#{Time.now.year}'&sort_order=name_asc&sport_code='mlb'")
        .to_return(body: '{"team_all_season":{"queryResults":{"row":[{"team_id":"139"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      transaction = Transaction.new(team_id: 139).team

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.team_all_season.bam?all_star_sw='N'&season='#{Time.now.year}'&sort_order=name_asc&sport_code='mlb'"
      assert_equal "139", transaction.team_id
    end

    def test_player
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=139")
        .to_return(body: '{"roster_40":{"queryResults":{"row":[{"player_id":"642350"}]}}}',
          headers: {"Content-Type" => "application/json;charset=ISO-8859-1"})
      transaction = Transaction.new(player_id: 642_350, team_id: 139)
      player = transaction.player

      assert_requested :get, "https://lookup-service-prod.mlb.com/json/named.roster_40.bam?team_id=139"
      assert_equal "642350", player.player_id
    end
  end
end
