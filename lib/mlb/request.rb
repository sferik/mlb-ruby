require 'faraday'

module MLB
  # @private
  class Request
    # Perform an HTTP GET request
    def self.get(path, options={})
      response = connection.get do |request|
        request.url(path, options)
      end
      response.body
    end

    private

    def self.connection
      Faraday::Connection.new(:url => 'http://api.freebase.com') do |connection|
        connection.use Faraday::Response::Yajl
        connection.adapter Faraday.default_adapter
      end
    end
  end
end
