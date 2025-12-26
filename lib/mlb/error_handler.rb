require "net/http"
require_relative "errors/bad_gateway"
require_relative "errors/bad_request"
require_relative "errors/connection_exception"
require_relative "errors/http_error"
require_relative "errors/forbidden"
require_relative "errors/gateway_timeout"
require_relative "errors/gone"
require_relative "errors/internal_server_error"
require_relative "errors/not_acceptable"
require_relative "errors/not_found"
require_relative "errors/payload_too_large"
require_relative "errors/service_unavailable"
require_relative "errors/too_many_requests"
require_relative "errors/unauthorized"
require_relative "errors/unprocessable_entity"

module MLB
  # Handles HTTP error responses from the MLB Stats API
  class ErrorHandler
    # Mapping of HTTP status codes to error classes
    ERROR_MAP = {
      400 => BadRequest,
      401 => Unauthorized,
      403 => Forbidden,
      404 => NotFound,
      406 => NotAcceptable,
      409 => ConnectionException,
      410 => Gone,
      413 => PayloadTooLarge,
      422 => UnprocessableEntity,
      429 => TooManyRequests,
      500 => InternalServerError,
      502 => BadGateway,
      503 => ServiceUnavailable,
      504 => GatewayTimeout
    }.freeze

    # Handles an HTTP response
    #
    # @api public
    # @example
    #   handler.handle(response: response)
    # @param response [Net::HTTPResponse] the HTTP response
    # @return [String, nil] the response body if successful
    # @raise [HTTPError] if the response is not successful
    def handle(response:)
      raise error(response) unless response.is_a?(Net::HTTPSuccess)

      response.body
    end

    private

    # Creates an error from a response
    #
    # @api private
    # @param response [Net::HTTPResponse] the HTTP response
    # @return [HTTPError] the error instance
    def error(response)
      error_class(response).new(response:)
    end

    # Returns the error class for a response
    #
    # @api private
    # @param response [Net::HTTPResponse] the HTTP response
    # @return [Class] the error class
    def error_class(response)
      ERROR_MAP[Integer(response.code)] || HTTPError
    end
  end
end
