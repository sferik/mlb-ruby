require_relative "../test_helper"

module MLB
  class StandingsTypeTest < Minitest::Test
    cover StandingsType

    def test_objects_with_same_name_are_equal
      standings_type1 = StandingsType.new(name: "regularSeason")
      standings_type2 = StandingsType.new(name: "regularSeason")

      assert_equal standings_type1, standings_type2
    end
  end
end
