require_relative "../test_helper"

module MLB
  class ScheduledGameTest < Minitest::Test
    cover ScheduledGame

    def test_equality
      game1 = ScheduledGame.new(game_pk: 744_834)
      game2 = ScheduledGame.new(game_pk: 744_834)
      game3 = ScheduledGame.new(game_pk: 744_835)

      assert_equal game1, game2
      refute_equal game1, game3
    end

    def test_tie?
      game = ScheduledGame.new(is_tie: true)

      assert_predicate game, :tie?

      game2 = ScheduledGame.new(is_tie: false)

      refute_predicate game2, :tie?
    end

    def test_day?
      day_game = ScheduledGame.new(day_night: "day")

      assert_predicate day_game, :day?
      refute_predicate day_game, :night?

      night_game = ScheduledGame.new(day_night: "night")

      refute_predicate night_game, :day?
    end

    def test_night?
      night_game = ScheduledGame.new(day_night: "night")

      assert_predicate night_game, :night?
      refute_predicate night_game, :day?

      day_game = ScheduledGame.new(day_night: "day")

      refute_predicate day_game, :night?
    end

    def test_double_header?
      regular_game = ScheduledGame.new(double_header: "N")

      refute_predicate regular_game, :double_header?

      yes_doubleheader = ScheduledGame.new(double_header: "Y")

      assert_predicate yes_doubleheader, :double_header?

      split_doubleheader = ScheduledGame.new(double_header: "S")

      assert_predicate split_doubleheader, :double_header?

      nil_doubleheader = ScheduledGame.new(double_header: nil)

      refute_predicate nil_doubleheader, :double_header?
    end

    def test_regular_season?
      regular_game = ScheduledGame.new(game_type: "R")

      assert_predicate regular_game, :regular_season?
      refute_predicate regular_game, :spring_training?

      spring_game = ScheduledGame.new(game_type: "S")

      refute_predicate spring_game, :regular_season?
    end

    def test_spring_training?
      spring_game = ScheduledGame.new(game_type: "S")

      assert_predicate spring_game, :spring_training?
      refute_predicate spring_game, :regular_season?

      regular_game = ScheduledGame.new(game_type: "R")

      refute_predicate regular_game, :spring_training?
    end

    def test_exhibition?
      exhibition_game = ScheduledGame.new(game_type: "E")

      assert_predicate exhibition_game, :exhibition?
      refute_predicate exhibition_game, :regular_season?

      regular_game = ScheduledGame.new(game_type: "R")

      refute_predicate regular_game, :exhibition?
    end

    def test_all_star?
      all_star_game = ScheduledGame.new(game_type: "A")

      assert_predicate all_star_game, :all_star?
      refute_predicate all_star_game, :regular_season?

      regular_game = ScheduledGame.new(game_type: "R")

      refute_predicate regular_game, :all_star?
    end

    def test_postseason_with_postseason_game_types
      wild_card = ScheduledGame.new(game_type: "F")
      division = ScheduledGame.new(game_type: "D")
      lcs = ScheduledGame.new(game_type: "L")
      world_series = ScheduledGame.new(game_type: "W")

      assert_predicate wild_card, :postseason?
      assert_predicate division, :postseason?
      assert_predicate lcs, :postseason?
      assert_predicate world_series, :postseason?
    end

    def test_postseason_with_non_postseason_game_types
      regular_game = ScheduledGame.new(game_type: "R")

      refute_predicate regular_game, :postseason?

      nil_game_type = ScheduledGame.new(game_type: nil)

      refute_predicate nil_game_type, :postseason?
    end
  end

  class ScheduledGameTeamTest < Minitest::Test
    cover ScheduledGameTeam

    def test_winner?
      team = ScheduledGameTeam.new(is_winner: true)

      assert_predicate team, :winner?

      team2 = ScheduledGameTeam.new(is_winner: false)

      refute_predicate team2, :winner?
    end
  end

  class ScheduledGameTeamsTest < Minitest::Test
    cover ScheduledGameTeams

    def test_home_and_away
      teams = ScheduledGameTeams.new(
        home: ScheduledGameTeam.new(score: 5),
        away: ScheduledGameTeam.new(score: 3)
      )

      assert_equal 5, teams.home.score
      assert_equal 3, teams.away.score
    end
  end
end
