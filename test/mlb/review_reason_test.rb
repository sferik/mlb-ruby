require_relative "../test_helper"

module MLB
  class ReviewReasonTest < Minitest::Test
    cover ReviewReason

    def test_objects_with_same_code_are_equal
      review_reason1 = ReviewReason.new(code: "A")
      review_reason2 = ReviewReason.new(code: "A")

      assert_equal review_reason1, review_reason2
    end
  end
end
