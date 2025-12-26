require_relative "../test_helper"

module MLB
  class StandingsRecordTest < Minitest::Test
    cover StandingsRecord

    def test_attributes
      record = StandingsRecord.new(
        standings_type: "regularSeason",
        division: Division.new(id: 201),
        team_records: [TeamRecord.new(team: Team.new(id: 147))]
      )

      assert_equal "regularSeason", record.standings_type
      assert_equal 201, record.division.id
      assert_equal 1, record.team_records.size
    end
  end
end
