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

  class StandingsRecordPredicatesTest < Minitest::Test
    cover StandingsRecord

    TYPE_PREDICATES = {
      "regularSeason" => :regular_season?,
      "wildCard" => :wild_card?,
      "springTraining" => :spring_training?,
      "postseason" => :postseason?
    }.freeze

    TYPE_PREDICATES.each do |standings_type, predicate|
      define_method("test_#{predicate}") do
        assert_predicate StandingsRecord.new(standings_type: standings_type), predicate
        refute_predicate StandingsRecord.new(standings_type: "OTHER"), predicate
      end
    end
  end
end
