require "forwardable"
require_relative "connection"
require_relative "redirect_handler"
require_relative "request_builder"
require_relative "response_parser"

module MLB
  class Client
    extend Forwardable

    DEFAULT_BASE_URL = "https://lookup-service-prod.mlb.com/json/".freeze
    DEFAULT_ARRAY_CLASS = Array
    DEFAULT_OBJECT_CLASS = Hash

    attr_accessor :base_url, :default_array_class, :default_object_class

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
      default_array_class: DEFAULT_ARRAY_CLASS,
      default_object_class: DEFAULT_OBJECT_CLASS,
      max_redirects: RedirectHandler::DEFAULT_MAX_REDIRECTS)

      @base_url = base_url
      initialize_default_classes(default_array_class, default_object_class)
      @connection = Connection.new(open_timeout:, read_timeout:, write_timeout:, debug_output:, proxy_url:)
      @request_builder = RequestBuilder.new
      @redirect_handler = RedirectHandler.new(connection: @connection, request_builder: @request_builder, max_redirects:)
      @response_parser = ResponseParser.new
    end

    def get(endpoint, headers: {}, array_class: default_array_class, object_class: default_object_class)
      execute_request(:get, endpoint, headers:, array_class:, object_class:)
    end

    def post(endpoint, body = nil, headers: {}, array_class: default_array_class, object_class: default_object_class)
      execute_request(:post, endpoint, body:, headers:, array_class:, object_class:)
    end

    def put(endpoint, body = nil, headers: {}, array_class: default_array_class, object_class: default_object_class)
      execute_request(:put, endpoint, body:, headers:, array_class:, object_class:)
    end

    def delete(endpoint, headers: {}, array_class: default_array_class, object_class: default_object_class)
      execute_request(:delete, endpoint, headers:, array_class:, object_class:)
    end

    private

    def initialize_default_classes(default_array_class, default_object_class)
      @default_array_class = default_array_class
      @default_object_class = default_object_class
    end

    def execute_request(http_method, endpoint, body: nil, headers: {}, array_class: default_array_class, object_class: default_object_class)
      uri = URI.join(base_url, endpoint)
      request = @request_builder.build(http_method:, uri:, body:, headers:)
      response = @connection.perform(request:)
      response = @redirect_handler.handle(response:, request:, base_url:)
      @response_parser.parse(response:, array_class:, object_class:)
    end
  end

  CLIENT = Client.new
end
