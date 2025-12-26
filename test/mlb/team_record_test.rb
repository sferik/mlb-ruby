require_relative "../test_helper"

module MLB
  class TeamRecordTest < Minitest::Test
    cover TeamRecord

    def test_equality
      record1 = TeamRecord.new(team: Team.new(id: 147))
      record2 = TeamRecord.new(team: Team.new(id: 147))
      record3 = TeamRecord.new(team: Team.new(id: 110))

      assert_equal record1, record2
      refute_equal record1, record3
    end

    def test_division_champ?
      record = TeamRecord.new(division_champ: true)

      assert_predicate record, :division_champ?

      record2 = TeamRecord.new(division_champ: false)

      refute_predicate record2, :division_champ?
    end

    def test_division_leader?
      record = TeamRecord.new(division_leader: true)

      assert_predicate record, :division_leader?

      record2 = TeamRecord.new(division_leader: false)

      refute_predicate record2, :division_leader?
    end

    def test_clinched?
      record = TeamRecord.new(clinched: true)

      assert_predicate record, :clinched?

      record2 = TeamRecord.new(clinched: false)

      refute_predicate record2, :clinched?
    end
  end

  class LeagueRecordTest < Minitest::Test
    cover LeagueRecord

    def test_attributes
      record = LeagueRecord.new(wins: 94, losses: 68, ties: 0, pct: ".580")

      assert_equal 94, record.wins
      assert_equal 68, record.losses
      assert_equal 0, record.ties
      assert_equal ".580", record.pct
    end
  end

  class StreakTest < Minitest::Test
    cover Streak

    def test_attributes
      streak = Streak.new(streak_code: "W3", streak_type: "wins", streak_number: 3)

      assert_equal "W3", streak.streak_code
      assert_equal "wins", streak.streak_type
      assert_equal 3, streak.streak_number
    end

    def test_winning?
      winning_streak = Streak.new(streak_type: "wins")

      assert_predicate winning_streak, :winning?
      refute_predicate winning_streak, :losing?

      losing_streak = Streak.new(streak_type: "losses")

      refute_predicate losing_streak, :winning?
    end

    def test_losing?
      losing_streak = Streak.new(streak_type: "losses")

      assert_predicate losing_streak, :losing?
      refute_predicate losing_streak, :winning?

      winning_streak = Streak.new(streak_type: "wins")

      refute_predicate winning_streak, :losing?
    end
  end
end
