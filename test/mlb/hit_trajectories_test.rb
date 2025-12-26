require_relative "../test_helper"

module MLB
  class HitTrajectoriesTest < Minitest::Test
    cover HitTrajectories

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/hitTrajectories")
        .to_return(body: '[{"code":"line_drive","description":"Line Drive"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      hit_trajectory = HitTrajectories.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/hitTrajectories"
      assert_equal "line_drive", hit_trajectory.code
      assert_equal "Line Drive", hit_trajectory.description
    end
  end
end
