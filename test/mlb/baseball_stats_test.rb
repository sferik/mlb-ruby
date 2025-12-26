require_relative "../test_helper"

module MLB
  class BaseballStatsTest < Minitest::Test
    cover BaseballStats

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/baseballStats")
        .to_return(body: '[{"name":"homeRuns","lookupParam":"hr","isCounting":true}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      stat = BaseballStats.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/baseballStats"
      assert_equal "homeRuns", stat.name
      assert_equal "hr", stat.lookup_param
      assert_predicate stat, :counting?
    end
  end
end
