require_relative "error"
require_relative "retryable"

module MLB
  # Error raised when a network connection fails.
  # These errors are typically transient and safe to retry.
  class NetworkError < Error
    include Retryable
  end
end
