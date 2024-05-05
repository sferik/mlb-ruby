require_relative "../test_helper"

module MLB
  class ClientRequestTest < Minitest::Test
    cover Client

    def setup
      @client = Client.new
    end

    MLB::RequestBuilder::HTTP_METHODS.each_key do |http_method|
      define_method :"test_#{http_method}_request" do
        stub_request(http_method, "https://lookup-service-prod.mlb.com/json/models")
        @client.public_send(http_method, "models")

        assert_requested http_method, "https://lookup-service-prod.mlb.com/json/models"
      end

      define_method :"test_#{http_method}_request_with_headers" do
        headers = {"User-Agent" => "Custom User Agent"}
        stub_request(http_method, "https://lookup-service-prod.mlb.com/json/models")
        @client.public_send(http_method, "models", headers:)

        assert_requested http_method, "https://lookup-service-prod.mlb.com/json/models", headers:
      end

      define_method :"test_#{http_method}_request_with_custom_response_objects" do
        stub_request(http_method, "https://lookup-service-prod.mlb.com/json/models")
          .to_return(body: '{"set": [1, 2, 2, 3]}', headers: {"Content-Type" => "application/json"})
        ostruct = @client.public_send(http_method, "models", object_class: OpenStruct, array_class: Set)

        assert_equal OpenStruct.new(set: Set.new([1, 2, 3])), ostruct
      end

      define_method :"test_#{http_method}_request_with_custom_response_objects_client_configuration" do
        stub_request(http_method, "https://lookup-service-prod.mlb.com/json/models")
          .to_return(body: '{"set": [1, 2, 2, 3]}', headers: {"Content-Type" => "application/json"})
        client = Client.new(default_object_class: OpenStruct, default_array_class: Set)
        ostruct = client.public_send(http_method, "models")

        assert_equal OpenStruct.new(set: Set.new([1, 2, 3])), ostruct
      end
    end

    def test_execute_request_with_custom_response_objects_client_configuration
      stub_request(:get, "https://lookup-service-prod.mlb.com/json/models")
        .to_return(body: '{"set": [1, 2, 2, 3]}', headers: {"Content-Type" => "application/json"})
      client = Client.new(default_object_class: OpenStruct, default_array_class: Set)
      ostruct = client.send(:execute_request, :get, "models")

      assert_kind_of OpenStruct, ostruct
      assert_kind_of Set, ostruct.set
      assert_equal Set.new([1, 2, 3]), ostruct.set
    end

    def test_redirect_handler_preserves_authentication
      client = Client.new(max_redirects: 5)
      stub_request(:get, "https://lookup-service-prod.mlb.com/old_endpoint")
        .to_return(status: 301, headers: {"Location" => "https://lookup-service-prod.mlb.com/new_endpoint"})
      stub_request(:get, "https://lookup-service-prod.mlb.com/new_endpoint")
      client.get("/old_endpoint")

      assert_requested :get, "https://lookup-service-prod.mlb.com/old_endpoint"
      assert_requested :get, "https://lookup-service-prod.mlb.com/new_endpoint"
    end

    def test_follows_301_redirect
      stub_request(:get, "https://lookup-service-prod.mlb.com/old_endpoint")
        .to_return(status: 301, headers: {"Location" => "https://lookup-service-prod.mlb.com/new_endpoint"})
      stub_request(:get, "https://lookup-service-prod.mlb.com/new_endpoint")
      @client.get("/old_endpoint")

      assert_requested :get, "https://lookup-service-prod.mlb.com/new_endpoint"
    end

    def test_follows_302_redirect
      stub_request(:get, "https://lookup-service-prod.mlb.com/old_endpoint")
        .to_return(status: 302, headers: {"Location" => "https://lookup-service-prod.mlb.com/new_endpoint"})
      stub_request(:get, "https://lookup-service-prod.mlb.com/new_endpoint")
      @client.get("/old_endpoint")

      assert_requested :get, "https://lookup-service-prod.mlb.com/new_endpoint"
    end

    def test_follows_307_redirect
      stub_request(:post, "https://lookup-service-prod.mlb.com/temporary_redirect")
        .to_return(status: 307, headers: {"Location" => "https://lookup-service-prod.mlb.com/new_endpoint"})
      body = {key: "value"}.to_json
      stub_request(:post, "https://lookup-service-prod.mlb.com/new_endpoint")
        .with(body:)
      @client.post("/temporary_redirect", body)

      assert_requested :post, "https://lookup-service-prod.mlb.com/new_endpoint", body:
    end

    def test_follows_308_redirect
      stub_request(:put, "https://lookup-service-prod.mlb.com/temporary_redirect")
        .to_return(status: 308, headers: {"Location" => "https://lookup-service-prod.mlb.com/new_endpoint"})
      body = {key: "value"}.to_json
      stub_request(:put, "https://lookup-service-prod.mlb.com/new_endpoint")
        .with(body:)
      @client.put("/temporary_redirect", body)

      assert_requested :put, "https://lookup-service-prod.mlb.com/new_endpoint", body:
    end

    def test_avoids_infinite_redirect_loop
      stub_request(:get, "https://lookup-service-prod.mlb.com/infinite_loop")
        .to_return(status: 302, headers: {"Location" => "https://lookup-service-prod.mlb.com/infinite_loop"})

      assert_raises TooManyRedirects do
        @client.get("/infinite_loop")
      end
    end
  end
end
