require "forwardable"
require "net/http"
require "openssl"
require "uri"
require_relative "errors/network_error"

module MLB
  # Manages HTTP connections to the MLB Stats API
  class Connection
    extend Forwardable

    # Default host for API requests
    DEFAULT_HOST = "statsapi.mlb.com".freeze
    # Default port for HTTPS connections
    DEFAULT_PORT = 443
    # Default connection open timeout in seconds
    DEFAULT_OPEN_TIMEOUT = 60 # seconds
    # Default read timeout in seconds
    DEFAULT_READ_TIMEOUT = 60 # seconds
    # Default write timeout in seconds
    DEFAULT_WRITE_TIMEOUT = 60 # seconds
    # Default debug output destination
    DEFAULT_DEBUG_OUTPUT = File.open(File::NULL, "w")
    # HTTPS scheme identifier
    HTTPS_SCHEME = "https".freeze
    # Network errors that trigger a NetworkError exception
    NETWORK_ERRORS = [
      Errno::ECONNREFUSED,
      Errno::ECONNRESET,
      Net::OpenTimeout,
      Net::ReadTimeout,
      OpenSSL::SSL::SSLError
    ].freeze

    # Returns the connection open timeout in seconds
    #
    # @api public
    # @example
    #   connection.open_timeout #=> 60
    # @return [Integer] the connection open timeout in seconds
    attr_accessor :open_timeout

    # @!method open_timeout=(value)
    #   Sets the connection open timeout in seconds
    #   @api public
    #   @example
    #     connection.open_timeout = 30
    #   @param value [Integer] the timeout in seconds
    #   @return [Integer] the timeout in seconds

    # Returns the read timeout in seconds
    #
    # @api public
    # @example
    #   connection.read_timeout #=> 60
    # @return [Integer] the read timeout in seconds
    attr_accessor :read_timeout

    # @!method read_timeout=(value)
    #   Sets the read timeout in seconds
    #   @api public
    #   @example
    #     connection.read_timeout = 30
    #   @param value [Integer] the timeout in seconds
    #   @return [Integer] the timeout in seconds

    # Returns the write timeout in seconds
    #
    # @api public
    # @example
    #   connection.write_timeout #=> 60
    # @return [Integer] the write timeout in seconds
    attr_accessor :write_timeout

    # @!method write_timeout=(value)
    #   Sets the write timeout in seconds
    #   @api public
    #   @example
    #     connection.write_timeout = 30
    #   @param value [Integer] the timeout in seconds
    #   @return [Integer] the timeout in seconds

    # Returns the IO object for debug output
    #
    # @api public
    # @example
    #   connection.debug_output #=> #<File:/dev/null>
    # @return [IO] the IO object for debug output
    attr_accessor :debug_output

    # @!method debug_output=(value)
    #   Sets the IO object for debug output
    #   @api public
    #   @example
    #     connection.debug_output = $stderr
    #   @param value [IO] the IO object for debug output
    #   @return [IO] the IO object for debug output

    # Returns the proxy URL
    #
    # @api public
    # @example
    #   connection.proxy_url #=> "http://proxy.example.com:8080"
    # @return [String, nil] the proxy URL
    attr_reader :proxy_url

    # Returns the parsed proxy URI
    #
    # @api public
    # @example
    #   connection.proxy_uri #=> #<URI::HTTP http://proxy.example.com:8080>
    # @return [URI::HTTP, nil] the parsed proxy URI
    attr_reader :proxy_uri

    def_delegator :proxy_uri, :host, :proxy_host
    def_delegator :proxy_uri, :port, :proxy_port
    def_delegator :proxy_uri, :user, :proxy_user
    def_delegator :proxy_uri, :password, :proxy_pass

    # Initializes a new Connection instance
    #
    # @api public
    # @example
    #   connection = MLB::Connection.new
    # @param open_timeout [Integer] the connection open timeout in seconds
    # @param read_timeout [Integer] the read timeout in seconds
    # @param write_timeout [Integer] the write timeout in seconds
    # @param debug_output [IO] the IO object for debug output
    # @param proxy_url [String, nil] the proxy URL
    def initialize(open_timeout: DEFAULT_OPEN_TIMEOUT, read_timeout: DEFAULT_READ_TIMEOUT,
      write_timeout: DEFAULT_WRITE_TIMEOUT, debug_output: DEFAULT_DEBUG_OUTPUT, proxy_url: nil)
      @open_timeout = open_timeout
      @read_timeout = read_timeout
      @write_timeout = write_timeout
      @debug_output = debug_output
      self.proxy_url = proxy_url if proxy_url
    end

    # Performs an HTTP request
    #
    # @api public
    # @example
    #   connection.perform(request: request)
    # @param request [Net::HTTPRequest] the HTTP request to perform
    # @return [Net::HTTPResponse] the HTTP response
    # @raise [NetworkError] if a network error occurs
    def perform(request:)
      uri = request.uri
      http_client = build_http_client(uri.host || DEFAULT_HOST, uri.port || DEFAULT_PORT)
      http_client.use_ssl = uri.scheme.eql?(HTTPS_SCHEME)
      http_client.request(request)
    rescue *NETWORK_ERRORS => e
      raise NetworkError, "Network error: #{e}"
    end

    # Sets the proxy URL
    #
    # @api public
    # @example
    #   connection.proxy_url = "http://proxy.example.com:8080"
    # @param proxy_url [String] the proxy URL
    # @return [void]
    # @raise [ArgumentError] if the proxy URL is invalid
    def proxy_url=(proxy_url)
      @proxy_url = proxy_url
      proxy_uri = URI(proxy_url)
      raise ArgumentError, "Invalid proxy URL: #{proxy_uri}" unless proxy_uri.is_a?(URI::HTTP)

      @proxy_uri = proxy_uri
    end

    private

    # Builds an HTTP client instance
    #
    # @api private
    # @param host [String] the host to connect to
    # @param port [Integer] the port to connect to
    # @return [Net::HTTP] the configured HTTP client
    def build_http_client(host = DEFAULT_HOST, port = DEFAULT_PORT)
      http_client = if proxy_uri
        Net::HTTP.new(host, port, proxy_host, proxy_port, proxy_user, proxy_pass)
      else
        Net::HTTP.new(host, port)
      end
      configure_http_client(http_client)
    end

    # Configures an HTTP client with timeout settings
    #
    # @api private
    # @param http_client [Net::HTTP] the HTTP client to configure
    # @return [Net::HTTP] the configured HTTP client
    def configure_http_client(http_client)
      http_client.tap do |c|
        c.open_timeout = open_timeout
        c.read_timeout = read_timeout
        c.write_timeout = write_timeout
        c.set_debug_output(debug_output)
      end
    end
  end
end
