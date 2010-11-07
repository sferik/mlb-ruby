require 'faraday'

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
      Faraday::Connection.new(:url => 'http://api.freebase.com') do |connection|
        connection.use Faraday::Response::Yajl unless raw
        connection.adapter Faraday.default_adapter
      end
    end
  end
end
