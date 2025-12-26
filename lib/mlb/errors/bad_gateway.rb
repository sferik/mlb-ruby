require_relative "server_error"

module MLB
  # Error raised for HTTP 502 Bad Gateway responses
  class BadGateway < ServerError; end
end
