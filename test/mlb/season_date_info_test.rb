require_relative "../test_helper"

module MLB
  class SeasonDateInfoTest < Minitest::Test
    cover SeasonDateInfo

    def test_objects_with_same_season_id_are_equal
      season_date_info0 = SeasonDateInfo.new(season_id: 0)
      season_date_info1 = SeasonDateInfo.new(season_id: 0)

      assert_equal season_date_info0, season_date_info1
    end
  end
end
