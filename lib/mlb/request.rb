require 'faraday'
require 'faraday_middleware'

module MLB
  # @private
  class Request
    # Perform an HTTP GET request
    def self.get(path, options={}, raw=false)
      response = connection(raw).get do |request|
        request.url(path, options)
      end
      raw ? response : response.body
    end

    private

    def self.connection(raw=false)
      Faraday.new(:url => 'http://api.freebase.com') do |builder|
        builder.use FaradayMiddleware::ParseJson unless raw
        builder.adapter Faraday.default_adapter
      end
    end
  end
end
