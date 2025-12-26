require_relative "server_error"

module MLB
  # Error raised for HTTP 500 Internal Server Error responses
  class InternalServerError < ServerError; end
end
