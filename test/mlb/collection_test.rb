require_relative "../test_helper"

module MLB
  class CollectionTest < Minitest::Test
    cover Collection

    def test_collection_sets_endpoint
      test_class = create_test_collection

      assert_equal "dynamic_items", test_class.endpoint
    end

    def test_collection_sets_collection_name
      test_class = create_test_collection

      assert_equal :items, test_class.collection_name
    end

    def test_collection_defines_attribute
      test_class = create_test_collection

      assert test_class.method_defined?(:items)
    end

    def test_collection_parses_json
      test_class = create_test_collection
      json = '{"items":["a","b","c"]}'
      result = test_class.from_json(json)

      assert_equal %w[a b c], result.items
    end

    def test_all_uses_endpoint
      stub_request(:get, "https://statsapi.mlb.com/api/v1/dynamic_items")
        .to_return(body: '["item1","item2"]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      test_class = create_test_collection
      results = test_class.all

      assert_requested :get, "https://statsapi.mlb.com/api/v1/dynamic_items"
      assert_equal %w[item1 item2], results
    end

    def test_all_uses_collection_name
      stub_request(:get, "https://statsapi.mlb.com/api/v1/dynamic_items")
        .to_return(body: '["item1","item2"]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      test_class = create_test_collection
      results = test_class.all

      assert_equal %w[item1 item2], results
    end

    def test_all_returns_empty_array_when_no_items
      stub_request(:get, "https://statsapi.mlb.com/api/v1/dynamic_items")
        .to_return(body: "[]",
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      test_class = create_test_collection
      results = test_class.all

      assert_empty results
    end

    def test_empty_returns_true_when_no_items
      stub_request(:get, "https://statsapi.mlb.com/api/v1/dynamic_items")
        .to_return(body: "[]",
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      test_class = create_test_collection

      assert_empty test_class
    end

    def test_empty_returns_false_when_items_exist
      stub_request(:get, "https://statsapi.mlb.com/api/v1/dynamic_items")
        .to_return(body: '["item1","item2"]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})

      test_class = create_test_collection

      refute_empty test_class
    end

    private

    def create_test_collection
      Class.new(Collection) do
        collection(endpoint: "dynamic_items", item_type: Shale::Type::String, collection_name: :items)
      end
    end
  end
end
