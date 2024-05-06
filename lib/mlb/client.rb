require "forwardable"
require_relative "connection"
require_relative "redirect_handler"
require_relative "request_builder"
require_relative "error_handler"

module MLB
  class Client
    extend Forwardable

    DEFAULT_BASE_URL = "https://statsapi.mlb.com/api/v1/".freeze

    attr_accessor :base_url

    def_delegators :@connection, :open_timeout, :read_timeout, :write_timeout, :proxy_url, :debug_output
    def_delegators :@connection, :open_timeout=, :read_timeout=, :write_timeout=, :proxy_url=, :debug_output=
    def_delegators :@redirect_handler, :max_redirects
    def_delegators :@redirect_handler, :max_redirects=

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

    def get(endpoint, headers: {})
      execute_request(:get, endpoint, headers:)
    end

    def post(endpoint, body = nil, headers: {})
      execute_request(:post, endpoint, body:, headers:)
    end

    def put(endpoint, body = nil, headers: {})
      execute_request(:put, endpoint, body:, headers:)
    end

    def delete(endpoint, headers: {})
      execute_request(:delete, endpoint, headers:)
    end

    private

    def execute_request(http_method, endpoint, headers:, body: nil)
      uri = URI.join(base_url, endpoint)
      request = @request_builder.build(http_method:, uri:, body:, headers:)
      response = @connection.perform(request:)
      response = @redirect_handler.handle(response:, request:, base_url:)
      @error_handler.handle(response:)
    end
  end

  CLIENT = Client.new
end
