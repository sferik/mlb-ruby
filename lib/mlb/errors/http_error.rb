require "json"
require_relative "error"

module MLB
  # HTTP error raised when an API request fails
  class HTTPError < Error
    # Returns the HTTP response
    #
    # @api public
    # @example
    #   error.response #=> #<Net::HTTPNotFound 404 Not Found>
    # @return [Net::HTTPResponse] the HTTP response
    attr_reader :response

    # Returns the HTTP status code
    #
    # @api public
    # @example
    #   error.code #=> "404"
    # @return [String] the HTTP status code
    attr_reader :code

    # Initializes a new HTTPError instance
    #
    # @api public
    # @example
    #   HTTPError.new(response: response)
    # @param response [Net::HTTPResponse] the HTTP response
    def initialize(response:)
      super(response.message)
      @response = response
      @code = response.code
    end
  end
end
