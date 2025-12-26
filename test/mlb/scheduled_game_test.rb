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
