module MLB
  # Provides comparison behavior for model classes by a specified attribute.
  # Handles nil values gracefully by placing them at the end when sorting.
  #
  # @api private
  # @example
  #   class Award < Shale::Mapper
  #     include Comparable
  #     include MLB::ComparableByAttribute
  #
  #     def comparable_attribute = :sort_order
  #   end
  module ComparableByAttribute
    # Compares this object with another by the comparable attribute
    #
    # @api public
    # @example
    #   award1 <=> award2 #=> -1
    # @param other [Object] the object to compare with
    # @return [Integer, nil] -1, 0, 1, or nil if not comparable
    def <=>(other)
      return nil unless other.is_a?(self.class) || is_a?(other.class)

      compare_values(
        public_send(comparable_attribute),
        other.public_send(comparable_attribute)
      )
    end

    private

    # Returns the attribute name used for comparison
    #
    # @api private
    # @abstract Override in including class
    # @return [Symbol] the attribute name
    def comparable_attribute
      raise NotImplementedError
    end

    # Compares two values, treating nil as greater than any value
    #
    # @api private
    # @param self_val [Object, nil] the value from self
    # @param other_val [Object, nil] the value from other
    # @return [Integer] -1, 0, or 1
    def compare_values(self_val, other_val)
      case [self_val, other_val]
      in [nil, nil] then 0
      in [nil, _] then 1
      in [_, nil] then -1
      else self_val <=> other_val
      end
    end
  end
end
