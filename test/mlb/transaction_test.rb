require_relative "../test_helper"

module MLB
  class TransactionTest < Minitest::Test
    cover Transaction

    def test_objects_with_same_id_are_equal
      transaction0 = Transaction.new(id: 0)
      transaction1 = Transaction.new(id: 0)

      assert_equal transaction0, transaction1
    end
  end

  class TransactionPredicatesTest < Minitest::Test
    cover Transaction

    TYPE_PREDICATES = {
      "TR" => :trade?,
      "FA" => :free_agent?,
      "ASG" => :assignment?,
      "SGN" => :signing?,
      "REL" => :release?,
      "WV" => :waiver?
    }.freeze

    TYPE_PREDICATES.each do |type_code, predicate|
      define_method("test_#{predicate}") do
        assert_predicate Transaction.new(type_code: type_code), predicate
        refute_predicate Transaction.new(type_code: "OTHER"), predicate
      end
    end
  end
end
