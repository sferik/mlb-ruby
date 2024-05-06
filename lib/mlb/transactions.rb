require "shale"
require "uri"
require_relative "transaction"

module MLB
  class Transactions < Shale::Mapper
    attribute :copyright, Shale::Type::String
    attribute :transactions, Transaction, collection: true

    def self.between(start_date: Date.today, end_date: start_date)
      params = {startDate: start_date, endDate: end_date}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("transactions?#{query_string}")
      transactions = from_json(response)
      transactions.transactions
    end
  end
end
