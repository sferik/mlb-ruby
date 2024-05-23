require_relative "../test_helper"

module MLB
  class StatusTest < Minitest::Test
    cover Status

    def test_objects_with_same_code_are_equal
      status0 = Status.new(code: 0)
      status1 = Status.new(code: 0)

      assert_equal status0, status1
    end
  end
end
