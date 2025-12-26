require_relative "client_error"

module MLB
  # Error raised for HTTP 404 Not Found responses
  class NotFound < ClientError; end
end
