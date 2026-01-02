require_relative "code_description_type"

module MLB
  # Represents handedness (batting or throwing side)
  class Handedness < CodeDescriptionType
    # Code for left-handed
    LEFT = "L".freeze
    # Code for right-handed
    RIGHT = "R".freeze
    # Code for switch hitter/thrower
    SWITCH = "S".freeze

    # Returns whether this is left-handed
    #
    # @api public
    # @example
    #   handedness.left? #=> true
    # @return [Boolean] whether this is left-handed
    def left? = code.eql?(LEFT)

    # Returns whether this is right-handed
    #
    # @api public
    # @example
    #   handedness.right? #=> false
    # @return [Boolean] whether this is right-handed
    def right? = code.eql?(RIGHT)

    # Returns whether this is switch (both sides)
    #
    # @api public
    # @example
    #   handedness.switch? #=> false
    # @return [Boolean] whether this is switch
    def switch? = code.eql?(SWITCH)
  end
end
