require_relative "../test_helper"

module MLB
  class LanguageTest < Minitest::Test
    cover Language

    def test_objects_with_same_language_id_are_equal
      language1 = Language.new(language_id: 1)
      language2 = Language.new(language_id: 1)

      assert_equal language1, language2
    end
  end
end
