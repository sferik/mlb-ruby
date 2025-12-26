require_relative "server_error"
require_relative "retryable"

module MLB
  # Error raised for HTTP 504 Gateway Timeout responses.
  # These errors indicate temporary infrastructure issues and are safe to retry.
  class GatewayTimeout < ServerError
    include Retryable
  end
end
