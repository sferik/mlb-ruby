require_relative "http_error"

module MLB
  # Error raised for HTTP 4xx client errors
  class ClientError < HTTPError; end
end
