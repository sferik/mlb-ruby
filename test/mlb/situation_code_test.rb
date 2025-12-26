require_relative "../test_helper"

module MLB
  class SituationCodeTest < Minitest::Test
    cover SituationCode

    def test_objects_with_same_code_are_equal
      situation_code1 = SituationCode.new(code: "h")
      situation_code2 = SituationCode.new(code: "h")

      assert_equal situation_code1, situation_code2
    end

    def test_team_predicate
      assert_predicate SituationCode.new(team: true), :team?
      refute_predicate SituationCode.new(team: false), :team?
      assert_nil SituationCode.new(team: nil).team?
    end

    def test_batting_predicate
      assert_predicate SituationCode.new(batting: true), :batting?
      refute_predicate SituationCode.new(batting: false), :batting?
      assert_nil SituationCode.new(batting: nil).batting?
    end

    def test_fielding_predicate
      assert_predicate SituationCode.new(fielding: true), :fielding?
      refute_predicate SituationCode.new(fielding: false), :fielding?
      assert_nil SituationCode.new(fielding: nil).fielding?
    end

    def test_pitching_predicate
      assert_predicate SituationCode.new(pitching: true), :pitching?
      refute_predicate SituationCode.new(pitching: false), :pitching?
      assert_nil SituationCode.new(pitching: nil).pitching?
    end
  end
end
