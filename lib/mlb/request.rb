require 'faraday'
require 'faraday_middleware'

module MLB
  # @private
  class Request
    # Perform an HTTP GET request
    def self.get(path, options = {})
      connection.get do |request|
        request.url(path, options)
      end.body
    end

  private

    def self.connection
      Faraday.new(:url => 'https://www.googleapis.com', :ssl => {:verify => false}) do |builder|
        builder.request :url_encoded
        builder.use FaradayMiddleware::ParseJson
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
