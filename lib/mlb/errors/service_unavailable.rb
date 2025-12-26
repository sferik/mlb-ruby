require_relative "server_error"
require_relative "retryable"

module MLB
  # Error raised for HTTP 503 Service Unavailable responses.
  # These errors indicate temporary server issues and are safe to retry.
  class ServiceUnavailable < ServerError
    include Retryable
  end
end
