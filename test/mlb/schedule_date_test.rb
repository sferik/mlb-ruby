require_relative "../test_helper"

module MLB
  class ScheduleDateTest < Minitest::Test
    cover ScheduleDate

    def test_attributes
      schedule_date = ScheduleDate.new(
        date: Date.new(2024, 7, 4),
        total_games: 15,
        games: [ScheduledGame.new(game_pk: 744_834)]
      )

      assert_equal Date.new(2024, 7, 4), schedule_date.date
      assert_equal 15, schedule_date.total_games
      assert_equal 1, schedule_date.games.size
      assert_equal 744_834, schedule_date.games.first.game_pk
    end
  end
end
