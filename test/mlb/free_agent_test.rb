require_relative "../test_helper"

module MLB
  class FreeAgentTest < Minitest::Test
    cover FreeAgent

    def test_equality
      agent1 = FreeAgent.new(player: Player.new(id: 123))
      agent2 = FreeAgent.new(player: Player.new(id: 123))

      assert_equal agent1, agent2
    end

    def test_inequality
      agent1 = FreeAgent.new(player: Player.new(id: 123))
      agent2 = FreeAgent.new(player: Player.new(id: 456))

      refute_equal agent1, agent2
    end
  end
end
