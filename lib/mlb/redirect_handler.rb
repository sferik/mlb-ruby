require "net/http"
require "uri"
require_relative "connection"
require_relative "errors/too_many_redirects"
require_relative "request_builder"

module MLB
  # Handles HTTP redirects for API requests
  class RedirectHandler
    # Default maximum number of redirects to follow
    DEFAULT_MAX_REDIRECTS = 10

    # Returns the maximum number of redirects to follow
    #
    # @api public
    # @example
    #   handler.max_redirects #=> 10
    # @return [Integer] the maximum redirects
    attr_accessor :max_redirects

    # @!method max_redirects=(value)
    #   Sets the maximum number of redirects to follow
    #   @api public
    #   @example
    #     handler.max_redirects = 5
    #   @param value [Integer] the maximum number of redirects
    #   @return [Integer] the maximum number of redirects

    # Returns the connection instance
    #
    # @api public
    # @example
    #   handler.connection #=> #<MLB::Connection>
    # @return [Connection] the connection instance
    attr_reader :connection

    # Returns the request builder instance
    #
    # @api public
    # @example
    #   handler.request_builder #=> #<MLB::RequestBuilder>
    # @return [RequestBuilder] the request builder instance
    attr_reader :request_builder

    # Initializes a new RedirectHandler instance
    #
    # @api public
    # @example
    #   handler = MLB::RedirectHandler.new
    # @param connection [Connection] the connection instance
    # @param request_builder [RequestBuilder] the request builder instance
    # @param max_redirects [Integer] the maximum number of redirects to follow
    def initialize(connection: Connection.new, request_builder: RequestBuilder.new,
      max_redirects: DEFAULT_MAX_REDIRECTS)
      @connection = connection
      @request_builder = request_builder
      @max_redirects = max_redirects
    end

    # Handles HTTP redirects
    #
    # @api public
    # @example
    #   handler.handle(response: response, request: request, base_url: "https://example.com")
    # @param response [Net::HTTPResponse] the HTTP response
    # @param request [Net::HTTPRequest] the original HTTP request
    # @param base_url [String] the base URL for relative redirects
    # @param redirect_count [Integer] the current redirect count
    # @return [Net::HTTPResponse] the final HTTP response
    # @raise [TooManyRedirects] if the maximum number of redirects is exceeded
    def handle(response:, request:, base_url:, redirect_count: 0)
      if response.is_a?(Net::HTTPRedirection)
        raise TooManyRedirects, "Too many redirects" if redirect_count > max_redirects

        new_uri = build_new_uri(response, base_url)

        new_request = build_request(request, new_uri, Integer(response.code))
        new_response = connection.perform(request: new_request)

        handle(response: new_response, request: new_request, base_url:, redirect_count: redirect_count + 1)
      else
        response
      end
    end

    private

    # Builds a new URI from a redirect response
    #
    # @api private
    # @param response [Net::HTTPResponse] the redirect response
    # @param base_url [String] the base URL for relative redirects
    # @return [URI::Generic] the new URI
    def build_new_uri(response, base_url)
      location = response.fetch("location")
      # If location is relative, it will join with the original base URL, otherwise it will overwrite it
      URI.join(base_url, location)
    end

    # Builds a new request for a redirect
    #
    # @api private
    # @param request [Net::HTTPRequest] the original request
    # @param uri [URI::Generic] the new URI
    # @param response_code [Integer] the redirect response code
    # @return [Net::HTTPRequest] the new request
    def build_request(request, uri, response_code)
      http_method, body = case response_code
      in 307 | 308
        [request.method.downcase.to_sym, request.body]
      else
        :get
      end

      request_builder.build(http_method:, uri:, body:)
    end
  end
end
