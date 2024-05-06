require_relative "../test_helper"

module MLB
  class ClientRequestTest < Minitest::Test
    cover Client

    def setup
      @client = Client.new
    end

    MLB::RequestBuilder::HTTP_METHODS.each_key do |http_method|
      define_method :"test_#{http_method}_request" do
        stub_request(http_method, "https://statsapi.mlb.com/api/v1/models")
        @client.public_send(http_method, "models")

        assert_requested http_method, "https://statsapi.mlb.com/api/v1/models"
      end

      define_method :"test_#{http_method}_request_with_headers" do
        headers = {"User-Agent" => "Custom User Agent"}
        stub_request(http_method, "https://statsapi.mlb.com/api/v1/models")
        @client.public_send(http_method, "models", headers:)

        assert_requested http_method, "https://statsapi.mlb.com/api/v1/models", headers:
      end
    end

    def test_redirect_handler_preserves_authentication
      client = Client.new(max_redirects: 5)
      stub_request(:get, "https://statsapi.mlb.com/old_endpoint")
        .to_return(status: 301, headers: {"Location" => "https://statsapi.mlb.com/new_endpoint"})
      stub_request(:get, "https://statsapi.mlb.com/new_endpoint")
      client.get("/old_endpoint")

      assert_requested :get, "https://statsapi.mlb.com/old_endpoint"
      assert_requested :get, "https://statsapi.mlb.com/new_endpoint"
    end

    def test_follows_301_redirect
      stub_request(:get, "https://statsapi.mlb.com/old_endpoint")
        .to_return(status: 301, headers: {"Location" => "https://statsapi.mlb.com/new_endpoint"})
      stub_request(:get, "https://statsapi.mlb.com/new_endpoint")
      @client.get("/old_endpoint")

      assert_requested :get, "https://statsapi.mlb.com/new_endpoint"
    end

    def test_follows_302_redirect
      stub_request(:get, "https://statsapi.mlb.com/old_endpoint")
        .to_return(status: 302, headers: {"Location" => "https://statsapi.mlb.com/new_endpoint"})
      stub_request(:get, "https://statsapi.mlb.com/new_endpoint")
      @client.get("/old_endpoint")

      assert_requested :get, "https://statsapi.mlb.com/new_endpoint"
    end

    def test_follows_307_redirect
      stub_request(:post, "https://statsapi.mlb.com/temporary_redirect")
        .to_return(status: 307, headers: {"Location" => "https://statsapi.mlb.com/new_endpoint"})
      body = {key: "value"}.to_json
      stub_request(:post, "https://statsapi.mlb.com/new_endpoint")
        .with(body:)
      @client.post("/temporary_redirect", body)

      assert_requested :post, "https://statsapi.mlb.com/new_endpoint", body:
    end

    def test_follows_308_redirect
      stub_request(:put, "https://statsapi.mlb.com/temporary_redirect")
        .to_return(status: 308, headers: {"Location" => "https://statsapi.mlb.com/new_endpoint"})
      body = {key: "value"}.to_json
      stub_request(:put, "https://statsapi.mlb.com/new_endpoint")
        .with(body:)
      @client.put("/temporary_redirect", body)

      assert_requested :put, "https://statsapi.mlb.com/new_endpoint", body:
    end

    def test_avoids_infinite_redirect_loop
      stub_request(:get, "https://statsapi.mlb.com/infinite_loop")
        .to_return(status: 302, headers: {"Location" => "https://statsapi.mlb.com/infinite_loop"})

      assert_raises TooManyRedirects do
        @client.get("/infinite_loop")
      end
    end
  end
end
