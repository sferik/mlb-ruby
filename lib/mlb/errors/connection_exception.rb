require_relative "client_error"

module MLB
  # Error raised for connection failures during HTTP requests
  class ConnectionException < ClientError; end
end
