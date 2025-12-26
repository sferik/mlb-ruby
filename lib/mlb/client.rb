require "forwardable"
require_relative "connection"
require_relative "redirect_handler"
require_relative "request_builder"
require_relative "error_handler"

module MLB
  # HTTP client for making requests to the MLB Stats API
  class Client
    extend Forwardable

    # Default base URL for the MLB Stats API
    DEFAULT_BASE_URL = "https://statsapi.mlb.com/api/v1/".freeze

    # Returns the base URL for API requests
    #
    # @api public
    # @example
    #   client.base_url #=> "https://statsapi.mlb.com/api/v1/"
    # @return [String] the base URL for API requests
    attr_accessor :base_url

    # @!method base_url=(value)
    #   Sets the base URL for API requests
    #   @api public
    #   @example
    #     client.base_url = "https://example.com/api/"
    #   @param value [String] the base URL for API requests
    #   @return [String] the base URL for API requests

    def_delegators :@connection, :open_timeout, :read_timeout, :write_timeout, :proxy_url, :debug_output
    def_delegators :@connection, :open_timeout=, :read_timeout=, :write_timeout=, :proxy_url=, :debug_output=
    def_delegators :@redirect_handler, :max_redirects
    def_delegators :@redirect_handler, :max_redirects=

    # Initializes a new Client instance
    #
    # @api public
    # @example
    #   client = MLB::Client.new
    # @param base_url [String] the base URL for API requests
    # @param open_timeout [Integer] the connection open timeout in seconds
    # @param read_timeout [Integer] the read timeout in seconds
    # @param write_timeout [Integer] the write timeout in seconds
    # @param debug_output [IO] the IO object for debug output
    # @param proxy_url [String, nil] the proxy URL
    # @param max_redirects [Integer] the maximum number of redirects to follow
    def initialize(base_url: DEFAULT_BASE_URL,
      open_timeout: Connection::DEFAULT_OPEN_TIMEOUT,
      read_timeout: Connection::DEFAULT_READ_TIMEOUT,
      write_timeout: Connection::DEFAULT_WRITE_TIMEOUT,
      debug_output: Connection::DEFAULT_DEBUG_OUTPUT,
      proxy_url: nil,
      max_redirects: RedirectHandler::DEFAULT_MAX_REDIRECTS)
      @base_url = base_url
      @connection = Connection.new(open_timeout:, read_timeout:, write_timeout:, debug_output:, proxy_url:)
      @request_builder = RequestBuilder.new
      @redirect_handler = RedirectHandler.new(connection: @connection, request_builder: @request_builder, max_redirects:)
      @error_handler = ErrorHandler.new
    end

    # Performs a GET request
    #
    # @api public
    # @example
    #   client.get("teams")
    # @param endpoint [String] the API endpoint
    # @param headers [Hash] optional HTTP headers
    # @return [String, nil] the response body
    def get(endpoint, headers: {})
      execute_request(:get, endpoint, headers:)
    end

    # Performs a POST request
    #
    # @api public
    # @example
    #   client.post("endpoint", '{"key": "value"}')
    # @param endpoint [String] the API endpoint
    # @param body [String, nil] the request body
    # @param headers [Hash] optional HTTP headers
    # @return [String, nil] the response body
    def post(endpoint, body = nil, headers: {})
      execute_request(:post, endpoint, body:, headers:)
    end

    # Performs a PUT request
    #
    # @api public
    # @example
    #   client.put("endpoint", '{"key": "value"}')
    # @param endpoint [String] the API endpoint
    # @param body [String, nil] the request body
    # @param headers [Hash] optional HTTP headers
    # @return [String, nil] the response body
    def put(endpoint, body = nil, headers: {})
      execute_request(:put, endpoint, body:, headers:)
    end

    # Performs a DELETE request
    #
    # @api public
    # @example
    #   client.delete("endpoint")
    # @param endpoint [String] the API endpoint
    # @param headers [Hash] optional HTTP headers
    # @return [String, nil] the response body
    def delete(endpoint, headers: {})
      execute_request(:delete, endpoint, headers:)
    end

    private

    # Executes an HTTP request
    #
    # @api private
    # @param http_method [Symbol] the HTTP method
    # @param endpoint [String] the API endpoint
    # @param headers [Hash] HTTP headers
    # @param body [String, nil] the request body
    # @return [String, nil] the response body
    def execute_request(http_method, endpoint, headers:, body: nil)
      uri = URI.join(base_url, endpoint)
      request = @request_builder.build(http_method:, uri:, body:, headers:)
      response = @connection.perform(request:)
      response = @redirect_handler.handle(response:, request:, base_url:)
      @error_handler.handle(response:)
    end
  end

  # Default client instance
  CLIENT = Client.new
end
