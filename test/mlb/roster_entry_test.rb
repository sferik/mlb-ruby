require_relative "../test_helper"

module MLB
  class RosterEntryTest < Minitest::Test
    cover RosterEntry

    def test_objects_with_same_team_id_and_player_are_equal
      roster_entry0 = RosterEntry.new(team_id: 0, player: Player.new(id: 0))
      roster_entry1 = RosterEntry.new(team_id: 0, player: Player.new(id: 0))

      assert_equal roster_entry0, roster_entry1
    end
  end
end
