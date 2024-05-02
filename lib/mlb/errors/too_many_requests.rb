require_relative "client_error"

module MLB
  class TooManyRequests < ClientError; end
end
