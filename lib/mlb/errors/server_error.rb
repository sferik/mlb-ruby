require_relative "http_error"

module MLB
  # Error raised for HTTP 5xx server errors
  class ServerError < HTTPError; end
end
