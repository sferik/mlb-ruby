require_relative "client_error"
require_relative "retryable"

module MLB
  # Error raised for HTTP 429 Too Many Requests responses.
  # These errors indicate rate limiting and are safe to retry after a delay.
  class TooManyRequests < ClientError
    include Retryable
  end
end
