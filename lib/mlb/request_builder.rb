require "net/http"
require "uri"
require_relative "version"

module MLB
  # Builds HTTP requests for the MLB Stats API
  class RequestBuilder
    # Default HTTP headers for API requests
    DEFAULT_HEADERS = {
      "Content-Type" => "application/json; charset=utf-8",
      "User-Agent" => "MLB-Client/#{VERSION} #{RUBY_ENGINE}/#{RUBY_VERSION} (#{RUBY_PLATFORM})"
    }.freeze
    # Mapping of HTTP method symbols to Net::HTTP request classes
    HTTP_METHODS = {
      get: Net::HTTP::Get,
      post: Net::HTTP::Post,
      put: Net::HTTP::Put,
      delete: Net::HTTP::Delete
    }.freeze

    # Builds an HTTP request
    #
    # @api public
    # @example
    #   builder.build(http_method: :get, uri: URI("https://example.com"))
    # @param http_method [Symbol] the HTTP method (:get, :post, :put, :delete)
    # @param uri [URI::Generic] the request URI
    # @param body [String, nil] the request body
    # @param headers [Hash] additional HTTP headers
    # @return [Net::HTTPRequest] the built HTTP request
    def build(http_method:, uri:, body: nil, headers: {})
      request = create_request(http_method:, uri:, body:)
      add_headers(request:, headers:)
      request
    end

    private

    # Creates an HTTP request object
    #
    # @api private
    # @param http_method [Symbol] the HTTP method
    # @param uri [URI::Generic] the request URI
    # @param body [String, nil] the request body
    # @return [Net::HTTPRequest] the created HTTP request
    # @raise [ArgumentError] if the HTTP method is not supported
    def create_request(http_method:, uri:, body:)
      http_method_class = HTTP_METHODS[http_method]

      raise ArgumentError, "Unsupported HTTP method: #{http_method}" unless http_method_class

      escaped_uri = escape_query_params(uri)
      request = http_method_class.new(escaped_uri)
      request.body = body
      request
    end

    # Adds headers to an HTTP request
    #
    # @api private
    # @param request [Net::HTTPRequest] the HTTP request
    # @param headers [Hash] additional headers to add
    # @return [void]
    def add_headers(request:, headers:)
      DEFAULT_HEADERS.merge(headers).each do |key, value|
        request.delete(key)
        request.add_field(key, value)
      end
    end

    # Escapes query parameters in a URI
    #
    # @api private
    # @param uri [URI::Generic] the URI to escape
    # @return [URI::Generic] the URI with escaped query parameters
    def escape_query_params(uri)
      URI(uri).tap { |u| u.query = URI.encode_www_form(URI.decode_www_form(u.query)) if u.query }
    end
  end
end
