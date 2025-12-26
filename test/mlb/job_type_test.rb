require_relative "../test_helper"

module MLB
  class JobTypeTest < Minitest::Test
    cover JobType

    def test_objects_with_same_code_are_equal
      job_type1 = JobType.new(code: "UMPR")
      job_type2 = JobType.new(code: "UMPR")

      assert_equal job_type1, job_type2
    end
  end
end
