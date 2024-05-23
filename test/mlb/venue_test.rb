require_relative "../test_helper"

module MLB
  class VenueTest < Minitest::Test
    cover Venue

    def test_objects_with_same_id_are_equal
      venue0 = Venue.new(id: 0)
      venue1 = Venue.new(id: 0)

      assert_equal venue0, venue1
    end
  end
end
