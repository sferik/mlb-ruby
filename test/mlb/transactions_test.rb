require_relative "../test_helper"

module MLB
  class TransactionTest < Minitest::Test
    cover Transactions

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/transactions?endDate=2024-05-04&startDate=2024-05-04")
        .to_return(body: '{"transactions":[{"id":123}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      transaction = Transactions.between(start_date: Date.parse("2024-05-04"), end_date: Date.parse("2024-05-04")).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/transactions?endDate=2024-05-04&startDate=2024-05-04"
      assert_equal 123, transaction.id
    end

    def test_self_between_without_end_date
      stub_request(:get, "https://statsapi.mlb.com/api/v1/transactions?endDate=2024-05-04&startDate=2024-05-04")
        .to_return(body: '{"transactions":[{"id":123}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      transaction = Transactions.between(start_date: Date.parse("2024-05-04")).first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/transactions?endDate=2024-05-04&startDate=2024-05-04"
      assert_equal 123, transaction.id
    end

    def test_self_between_without_start_or_end_date
      stub_request(:get, "https://statsapi.mlb.com/api/v1/transactions?endDate=#{Date.today}&startDate=#{Date.today}")
        .to_return(body: '{"transactions":[{"id":123}]}', headers: {"Content-Type" => "application/json;charset=UTF-8"})
      transaction = Transactions.between.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/transactions?endDate=#{Date.today}&startDate=#{Date.today}"
      assert_equal 123, transaction.id
    end
  end
end
