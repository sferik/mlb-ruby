require_relative "../test_helper"

module MLB
  class LinescoreTest < Minitest::Test
    cover Linescore

    def test_self_find_with_game_pk
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: linescore_json, headers: json_headers)
      linescore = Linescore.find(game: 745_726)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/game/745726/linescore"
      assert_equal 9, linescore.current_inning
      assert_equal "9th", linescore.current_inning_ordinal
      refute_predicate linescore, :top_inning?
    end

    def test_self_find_with_game_object
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: simple_linescore_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_726)
      linescore = Linescore.find(game:)

      assert_equal 9, linescore.current_inning
      assert_equal 4, linescore.teams.home.runs
      assert_equal 8, linescore.teams.away.runs
    end

    def test_innings
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: innings_json, headers: json_headers)
      linescore = Linescore.find(game: 745_726)

      assert_equal 1, linescore.innings.size
    end

    def test_inning_details
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: innings_json, headers: json_headers)
      inning = Linescore.find(game: 745_726).innings.first

      assert_equal 1, inning.num
      assert_equal 2, inning.home.runs
      assert_equal 1, inning.away.runs
    end

    def test_top_inning
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: top_inning_json, headers: json_headers)
      linescore = Linescore.find(game: 745_726)

      assert_predicate linescore, :top_inning?
    end

    def test_teams_winner
      stub_request(:get, "https://statsapi.mlb.com/api/v1/game/745726/linescore")
        .to_return(body: winner_json, headers: json_headers)
      linescore = Linescore.find(game: 745_726)

      refute_predicate linescore.teams.home, :winner?
      assert_predicate linescore.teams.away, :winner?
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def linescore_json
      '{"copyright":"Copyright","currentInning":9,"currentInningOrdinal":"9th",' \
        '"inningState":"Bottom","inningHalf":"Bottom","isTopInning":false,' \
        '"scheduledInnings":9,"innings":[],"teams":{"home":{"runs":4},"away":{"runs":8}}}'
    end

    def simple_linescore_json
      '{"currentInning":9,"scheduledInnings":9,"innings":[],' \
        '"teams":{"home":{"runs":4},"away":{"runs":8}}}'
    end

    def innings_json
      '{"currentInning":9,"scheduledInnings":9,"innings":[{"num":1,"ordinalNum":"1st",' \
        '"home":{"runs":2,"hits":3,"errors":0,"leftOnBase":1},' \
        '"away":{"runs":1,"hits":2,"errors":1,"leftOnBase":2}}],' \
        '"teams":{"home":{"runs":4},"away":{"runs":8}}}'
    end

    def winner_json
      '{"currentInning":9,"scheduledInnings":9,"innings":[],' \
        '"teams":{"home":{"runs":4,"isWinner":false},"away":{"runs":8,"isWinner":true}}}'
    end

    def top_inning_json
      '{"currentInning":1,"isTopInning":true,"scheduledInnings":9,"innings":[],' \
        '"teams":{"home":{"runs":0},"away":{"runs":0}}}'
    end
  end

  class LinescorePredicatesTest < Minitest::Test
    cover Linescore

    def test_top?
      top_linescore = Linescore.new(inning_state: "Top")

      assert_predicate top_linescore, :top?
      refute_predicate top_linescore, :middle?
      refute_predicate top_linescore, :bottom?

      bottom_linescore = Linescore.new(inning_state: "Bottom")

      refute_predicate bottom_linescore, :top?
    end

    def test_middle?
      middle_linescore = Linescore.new(inning_state: "Middle")

      assert_predicate middle_linescore, :middle?
      refute_predicate middle_linescore, :top?
      refute_predicate middle_linescore, :bottom?

      top_linescore = Linescore.new(inning_state: "Top")

      refute_predicate top_linescore, :middle?
    end

    def test_bottom?
      bottom_linescore = Linescore.new(inning_state: "Bottom")

      assert_predicate bottom_linescore, :bottom?
      refute_predicate bottom_linescore, :top?
      refute_predicate bottom_linescore, :middle?

      top_linescore = Linescore.new(inning_state: "Top")

      refute_predicate top_linescore, :bottom?
    end

    INNING_PREDICATES = {
      1 => :first?, 2 => :second?, 3 => :third?, 4 => :fourth?, 5 => :fifth?,
      6 => :sixth?, 7 => :seventh?, 8 => :eighth?, 9 => :ninth?, 10 => :tenth?,
      11 => :eleventh?, 12 => :twelfth?, 13 => :thirteenth?, 14 => :fourteenth?,
      15 => :fifteenth?, 16 => :sixteenth?, 17 => :seventeenth?, 18 => :eighteenth?,
      19 => :nineteenth?, 20 => :twentieth?, 21 => :twenty_first?, 22 => :twenty_second?,
      23 => :twenty_third?, 24 => :twenty_fourth?, 25 => :twenty_fifth?, 26 => :twenty_sixth?
    }.freeze

    INNING_PREDICATES.each do |inning, predicate|
      define_method("test_#{predicate}") do
        assert_predicate Linescore.new(current_inning: inning), predicate
        refute_predicate Linescore.new(current_inning: (inning == 1) ? 2 : 1), predicate
      end
    end
  end
end
