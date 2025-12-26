require_relative "../test_helper"

module MLB
  class JobTest < Minitest::Test
    cover Job

    def test_equality
      job1 = Job.new(person: Player.new(id: 123))
      job2 = Job.new(person: Player.new(id: 123))

      assert_equal job1, job2
    end

    def test_inequality
      job1 = Job.new(person: Player.new(id: 123))
      job2 = Job.new(person: Player.new(id: 456))

      refute_equal job1, job2
    end
  end
end
