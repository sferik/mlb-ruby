require "shale"
require "uri"
require_relative "transaction"

module MLB
  # Provides methods for fetching MLB transactions from the API
  class Transactions < Shale::Mapper
    # @!attribute [rw] copyright
    #   Returns the API copyright notice
    #   @api public
    #   @example
    #     transactions_response.copyright #=> "Copyright 2024 MLB Advanced Media..."
    #   @return [String] the API copyright notice
    attribute :copyright, Shale::Type::String

    # @!attribute [rw] transactions
    #   Returns the collection of transactions
    #   @api public
    #   @example
    #     transactions_response.transactions #=> [#<MLB::Transaction>, ...]
    #   @return [Array<Transaction>] the collection of transactions
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
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("transactions?#{query_string}")
      transactions = from_json(response)
      transactions.transactions
    end
  end
end
