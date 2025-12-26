require "shale"
require_relative "transaction"

module MLB
  # Provides methods for fetching MLB transactions from the API
  class Transactions < Shale::Mapper
    attribute :transactions, Transaction, collection: true

    # Retrieves transactions between two dates
    #
    # @api public
    # @example
    #   MLB::Transactions.between(start_date: Date.new(2024, 1, 1), end_date: Date.new(2024, 1, 31))
    # @param start_date [Date] the start date
    # @param end_date [Date] the end date
    # @return [Array<Transaction>] the list of transactions
    def self.between(start_date: Date.today, end_date: start_date)
      params = {startDate: start_date, endDate: end_date}
      response = CLIENT.get("transactions?#{Utils.build_query(params)}")
      from_json(response).transactions
    end
  end
end
