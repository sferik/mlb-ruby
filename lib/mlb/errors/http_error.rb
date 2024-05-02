require "json"
require_relative "error"

module MLB
  class HTTPError < Error
    attr_reader :response, :code

    def initialize(response:)
      super(response.message)
      @response = response
      @code = response.code
    end
  end
end
