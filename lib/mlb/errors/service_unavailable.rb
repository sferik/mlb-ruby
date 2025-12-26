require_relative "server_error"

module MLB
  # Error raised for HTTP 503 Service Unavailable responses
  class ServiceUnavailable < ServerError; end
end
