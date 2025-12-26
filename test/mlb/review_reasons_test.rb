require_relative "../test_helper"

module MLB
  class ReviewReasonsTest < Minitest::Test
    cover ReviewReasons

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/reviewReasons")
        .to_return(body: '[{"code":"A","description":"Tag play"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      review_reason = ReviewReasons.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/reviewReasons"
      assert_equal "A", review_reason.code
      assert_equal "Tag play", review_reason.description
    end
  end
end
