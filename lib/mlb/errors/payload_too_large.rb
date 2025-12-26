require_relative "client_error"

module MLB
  # Error raised for HTTP 413 Payload Too Large responses
  class PayloadTooLarge < ClientError; end
end
