require "equalizer"
require "shale"

module MLB
  # Represents a pitch code (result of a pitch)
  class PitchCode < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the pitch code
    #   @api public
    #   @example
    #     pitch_code.code #=> "B"
    #   @return [String] the pitch code
    attribute :code, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the description
    #   @api public
    #   @example
    #     pitch_code.description #=> "Ball"
    #   @return [String] the description
    attribute :description, Shale::Type::String

    # @!attribute [rw] swing_status
    #   Returns whether the batter swung
    #   @api public
    #   @example
    #     pitch_code.swing_status #=> false
    #   @return [Boolean] whether the batter swung
    attribute :swing_status, Shale::Type::Boolean

    # @!attribute [rw] strike_status
    #   Returns whether this counts as a strike
    #   @api public
    #   @example
    #     pitch_code.strike_status #=> false
    #   @return [Boolean] whether this counts as a strike
    attribute :strike_status, Shale::Type::Boolean

    # @!attribute [rw] ball_status
    #   Returns whether this counts as a ball
    #   @api public
    #   @example
    #     pitch_code.ball_status #=> true
    #   @return [Boolean] whether this counts as a ball
    attribute :ball_status, Shale::Type::Boolean

    # @!attribute [rw] sort_order
    #   Returns the sort order
    #   @api public
    #   @example
    #     pitch_code.sort_order #=> 1
    #   @return [Integer] the sort order
    attribute :sort_order, Shale::Type::Integer

    # Returns whether the batter swung
    #
    # @api public
    # @example
    #   pitch_code.swing? #=> false
    # @return [Boolean] whether the batter swung
    def swing? = swing_status

    # Returns whether this counts as a strike
    #
    # @api public
    # @example
    #   pitch_code.strike? #=> false
    # @return [Boolean] whether this counts as a strike
    def strike? = strike_status

    # Returns whether this counts as a ball
    #
    # @api public
    # @example
    #   pitch_code.ball? #=> true
    # @return [Boolean] whether this counts as a ball
    def ball? = ball_status

    json do
      map "code", to: :code
      map "description", to: :description
      map "swingStatus", to: :swing_status
      map "strikeStatus", to: :strike_status
      map "ballStatus", to: :ball_status
      map "sortOrder", to: :sort_order
    end
  end
end
