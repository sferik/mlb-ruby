require_relative "client_error"

module MLB
  # Error raised for HTTP 410 Gone responses
  class Gone < ClientError; end
end
