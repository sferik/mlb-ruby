require_relative "../test_helper"

module MLB
  class LeagueLeaderTypeTest < Minitest::Test
    cover LeagueLeaderType

    def test_objects_with_same_display_name_are_equal
      leader_type1 = LeagueLeaderType.new(display_name: "homeRuns")
      leader_type2 = LeagueLeaderType.new(display_name: "homeRuns")

      assert_equal leader_type1, leader_type2
    end
  end
end
