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
end
