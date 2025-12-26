require_relative "server_error"
require_relative "retryable"

module MLB
  # Error raised for HTTP 502 Bad Gateway responses.
  # These errors indicate temporary proxy/gateway issues and are safe to retry.
  class BadGateway < ServerError
    include Retryable
  end
end
