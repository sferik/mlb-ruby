require_relative "../test_helper"

module MLB
  class StreaksTest < Minitest::Test
    cover Streaks

    def test_self_hitting
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streaks = Streaks.hitting

      assert_equal 2, streaks.size
      assert_equal 660_271, streaks.first.player_id
      assert_equal "hittingStreak", streaks.first.streak_type
    end

    def test_self_hitting_with_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=2023&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streaks = Streaks.hitting(season: 2023)

      assert_equal 2, streaks.size
    end

    def test_self_hitting_with_limit
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=5&season=#{year}&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streaks = Streaks.hitting(limit: 5)

      assert_equal 2, streaks.size
    end

    def test_self_find
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streaks = Streaks.find(streak_type: "hittingStreak")

      assert_equal 2, streaks.size
    end

    def test_self_find_empty_result
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: '{"copyright":"Copyright","streakStats":[]}', headers: json_headers)
      streaks = Streaks.find(streak_type: "hittingStreak")

      assert_empty streaks
    end

    def test_streak_attributes
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streak = Streaks.hitting.first

      assert_equal "Shohei Ohtani", streak.player_name
      assert_equal 15, streak.current_streak
      assert_equal "20-for-58", streak.current_streak_stat
    end

    def test_streak_team
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: streaks_json, headers: json_headers)
      streak = Streaks.hitting.first

      assert_equal 119, streak.team.id
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def streaks_json
      '{"copyright":"Copyright","streakStats":[{"streakType":"hittingStreak",' \
        '"streaks":[{"playerId":660271,"playerName":"Shohei Ohtani",' \
        '"streakType":"hittingStreak","currentStreak":15,' \
        '"currentStreakStat":"20-for-58","team":{"id":119}},' \
        '{"playerId":605141,"playerName":"Mookie Betts",' \
        '"streakType":"hittingStreak","currentStreak":12,' \
        '"currentStreakStat":"16-for-45","team":{"id":119}}]}]}'
    end
  end

  class StreaksFindMultiCategoryTest < Minitest::Test
    cover Streaks

    def test_find_returns_first_category_streaks
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=hittingStreak")
        .to_return(body: multi_category_streaks_json, headers: json_headers)
      streaks = Streaks.find(streak_type: "hittingStreak")

      assert_equal 1, streaks.size
      assert_equal 660_271, streaks.first.player_id
      assert_equal 15, streaks.first.current_streak
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def multi_category_streaks_json
      first_cat = '{"streakType":"hittingStreak","streaks":[' \
                  '{"playerId":660271,"playerName":"Shohei Ohtani","streakType":"hittingStreak",' \
                  '"currentStreak":15,"currentStreakStat":"20-for-58","team":{"id":119}}]}'
      second_cat = '{"streakType":"onBaseStreak","streaks":[' \
                   '{"playerId":605141,"playerName":"Mookie Betts","streakType":"onBaseStreak",' \
                   '"currentStreak":25,"currentStreakStat":"30 times","team":{"id":119}}]}'
      %({"copyright":"Copyright","streakStats":[#{first_cat},#{second_cat}]})
    end
  end

  class StreaksOnBaseTest < Minitest::Test
    cover Streaks

    def test_self_on_base
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=#{year}&streakType=onBaseStreak")
        .to_return(body: on_base_streaks_json, headers: json_headers)
      streaks = Streaks.on_base

      assert_equal 1, streaks.size
      assert_equal "onBaseStreak", streaks.first.streak_type
    end

    def test_self_on_base_with_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=10&season=2023&streakType=onBaseStreak")
        .to_return(body: on_base_streaks_json, headers: json_headers)
      streaks = Streaks.on_base(season: 2023)

      assert_equal 1, streaks.size
    end

    def test_self_on_base_with_limit
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/stats/streaks?limit=5&season=#{year}&streakType=onBaseStreak")
        .to_return(body: on_base_streaks_json, headers: json_headers)
      streaks = Streaks.on_base(limit: 5)

      assert_equal 1, streaks.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def on_base_streaks_json
      '{"copyright":"Copyright","streakStats":[{"streakType":"onBaseStreak",' \
        '"streaks":[{"playerId":660271,"playerName":"Shohei Ohtani",' \
        '"streakType":"onBaseStreak","currentStreak":20,' \
        '"currentStreakStat":"25 times","team":{"id":119}}]}]}'
    end
  end

  class PlayerStreakTest < Minitest::Test
    cover PlayerStreak

    def test_equality
      s1 = PlayerStreak.new(player_id: 660_271, streak_type: "hittingStreak", current_streak: 15)
      s2 = PlayerStreak.new(player_id: 660_271, streak_type: "hittingStreak", current_streak: 15)

      assert_equal s1, s2
    end

    def test_inequality
      s1 = PlayerStreak.new(player_id: 660_271, streak_type: "hittingStreak", current_streak: 15)
      s2 = PlayerStreak.new(player_id: 605_141, streak_type: "hittingStreak", current_streak: 12)

      refute_equal s1, s2
    end

    def test_hitting_streak_predicate
      assert_predicate PlayerStreak.new(streak_type: "hittingStreak"), :hitting_streak?
      refute_predicate PlayerStreak.new(streak_type: "onBaseStreak"), :hitting_streak?
    end

    def test_on_base_streak_predicate
      assert_predicate PlayerStreak.new(streak_type: "onBaseStreak"), :on_base_streak?
      refute_predicate PlayerStreak.new(streak_type: "hittingStreak"), :on_base_streak?
    end
  end

  class StreakCategoryTest < Minitest::Test
    cover StreakCategory

    def test_hitting_streak_predicate
      assert_predicate StreakCategory.new(category_type: "hittingStreak"), :hitting_streak?
      refute_predicate StreakCategory.new(category_type: "onBaseStreak"), :hitting_streak?
    end

    def test_on_base_streak_predicate
      assert_predicate StreakCategory.new(category_type: "onBaseStreak"), :on_base_streak?
      refute_predicate StreakCategory.new(category_type: "hittingStreak"), :on_base_streak?
    end
  end
end
