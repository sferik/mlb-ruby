require "ostruct"
require_relative "../test_helper"

module MLB
  class ErrorHandlerTest < Minitest::Test
    cover ErrorHandler

    def setup
      @error_handler = ErrorHandler.new
      @uri = URI("http://example.com")
    end

    def response(uri = @uri)
      Net::HTTP.get_response(uri)
    end

    def test_success_response
      stub_request(:get, @uri.to_s)
        .to_return(body: '{"message":"success"}', headers: {"Content-Type" => "application/json"})

      assert_equal('{"message":"success"}', @error_handler.handle(response:))
    end

    def test_that_it_parses_204_no_content_response
      stub_request(:get, @uri.to_s).to_return(status: 204)

      assert_nil @error_handler.handle(response:)
    end

    def test_bad_request_error
      stub_request(:get, @uri.to_s).to_return(status: 400)
      exception = assert_raises(BadRequest) { @error_handler.handle(response:) }

      assert_kind_of Net::HTTPBadRequest, exception.response
      assert_equal "400", exception.code
    end

    def test_unknown_error_code
      stub_request(:get, @uri.to_s).to_return(status: 418)
      assert_raises(Error) { @error_handler.handle(response:) }
    end

    def test_error_with_title_only
      stub_request(:get, @uri.to_s)
        .to_return(status: [400, "Bad Request"], body: '{"title": "Some Error"}', headers: {"Content-Type" => "application/json"})
      exception = assert_raises(BadRequest) { @error_handler.handle(response:) }

      assert_equal "Bad Request", exception.message
    end

    def test_error_with_detail_only
      stub_request(:get, @uri.to_s)
        .to_return(status: [400, "Bad Request"],
          body: '{"detail": "Something went wrong"}', headers: {"Content-Type" => "application/json"})
      exception = assert_raises(BadRequest) { @error_handler.handle(response:) }

      assert_equal "Bad Request", exception.message
    end

    def test_non_json_error_response
      stub_request(:get, @uri.to_s)
        .to_return(status: [400, "Bad Request"], body: "<html>Bad Request</html>", headers: {"Content-Type" => "text/html"})
      exception = assert_raises(BadRequest) { @error_handler.handle(response:) }

      assert_equal "Bad Request", exception.message
    end
  end
end
