require_relative "../test_helper"

module MLB
  class ComparableByAttributeTest < Minitest::Test
    cover ComparableByAttribute

    def test_compares_by_attribute
      klass = create_test_class(:value)
      obj1 = klass.new(1)
      obj2 = klass.new(2)

      assert_equal(-1, obj1 <=> obj2)
      assert_equal(1, obj2 <=> obj1)
      assert_equal(0, obj1 <=> klass.new(1))
    end

    def test_nil_values_sort_to_end
      klass = create_test_class(:value)
      with_value = klass.new(1)
      without_value = klass.new(nil)

      assert_equal(-1, with_value <=> without_value)
      assert_equal(1, without_value <=> with_value)
    end

    def test_both_nil_values_are_equal
      klass = create_test_class(:value)
      obj1 = klass.new(nil)
      obj2 = klass.new(nil)

      assert_equal(0, obj1 <=> obj2)
    end

    def test_comparison_with_different_type_returns_nil
      klass = create_test_class(:value)
      obj = klass.new(1)

      assert_nil(obj <=> "not the same type")
    end

    def test_comparison_works_with_subclass
      klass = create_test_class(:value)
      subclass = Class.new(klass)
      obj = klass.new(2)
      subclass_obj = subclass.new(1)

      assert_equal(1, obj <=> subclass_obj)
      assert_equal(-1, subclass_obj <=> obj)
    end

    def test_works_with_different_attributes
      klass = create_test_class(:score)
      obj1 = klass.new(10)
      obj2 = klass.new(20)

      assert_equal(-1, obj1 <=> obj2)
    end

    def test_raises_error_if_comparable_attribute_not_defined
      klass = Class.new do
        include Comparable
        include ComparableByAttribute

        attr_accessor :value

        def initialize(val)
          @value = val
        end
      end

      assert_raises(NotImplementedError) { klass.new(1) <=> klass.new(2) }
    end

    private

    def create_test_class(attribute)
      Class.new do
        include Comparable
        include ComparableByAttribute

        attr_accessor attribute

        define_method(:comparable_attribute) { attribute }

        define_method(:initialize) do |val|
          instance_variable_set(:"@#{attribute}", val)
        end
      end
    end
  end
end
