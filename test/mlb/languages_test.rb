require_relative "../test_helper"

module MLB
  class LanguagesTest < Minitest::Test
    cover Languages

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/languages")
        .to_return(body: '[{"languageId":1,"languageCode":"en","name":"English","locale":"en_US"}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      language = Languages.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/languages"
      assert_equal 1, language.language_id
      assert_equal "English", language.name
    end
  end
end
