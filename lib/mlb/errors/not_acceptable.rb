require_relative "client_error"

module MLB
  # Error raised for HTTP 406 Not Acceptable responses
  class NotAcceptable < ClientError; end
end
