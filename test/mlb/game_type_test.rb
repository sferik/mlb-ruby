require_relative "../test_helper"

module MLB
  class GameTypeTest < Minitest::Test
    cover GameType

    def test_objects_with_same_id_are_equal
      game_type1 = GameType.new(id: "R")
      game_type2 = GameType.new(id: "R")

      assert_equal game_type1, game_type2
    end

    def test_to_s_returns_id_and_description
      game_type = GameType.new(id: "R", description: "Regular Season")

      assert_equal "R (Regular Season)", game_type.to_s
    end
  end

  class GameTypePredicatesTest < Minitest::Test
    cover GameType

    TYPE_PREDICATES = {
      "R" => :regular_season?,
      "S" => :spring_training?,
      "E" => :exhibition?,
      "A" => :all_star?,
      "F" => :wild_card?,
      "D" => :division_series?,
      "L" => :lcs?,
      "W" => :world_series?
    }.freeze

    TYPE_PREDICATES.each do |type_id, predicate|
      define_method("test_#{predicate}") do
        assert_predicate GameType.new(id: type_id), predicate
        refute_predicate GameType.new(id: "X"), predicate
      end
    end

    def test_postseason_with_wild_card
      assert_predicate GameType.new(id: "F"), :postseason?
    end

    def test_postseason_with_division_series
      assert_predicate GameType.new(id: "D"), :postseason?
    end

    def test_postseason_with_lcs
      assert_predicate GameType.new(id: "L"), :postseason?
    end

    def test_postseason_with_world_series
      assert_predicate GameType.new(id: "W"), :postseason?
    end

    def test_postseason_with_regular_season
      refute_predicate GameType.new(id: "R"), :postseason?
    end

    def test_postseason_with_nil_id
      refute_predicate GameType.new(id: nil), :postseason?
    end
  end
end
