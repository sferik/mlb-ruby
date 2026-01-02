require "forwardable"
require "shale"

module MLB
  # Base class for simple collection endpoints that only need an .all method.
  # Provides a class macro to define the endpoint, item type, and attribute name,
  # eliminating repetitive boilerplate across 20+ similar collection classes.
  #
  # @api private
  class Collection < Shale::Mapper
    extend SingleForwardable

    # @!method any?
    #   Checks if the collection has any items
    #   @api public
    #   @example
    #     MLB::Sports.any? #=> true
    #   @return [Boolean] true if the collection has any items
    # @!method count
    #   Returns the number of items in the collection
    #   @api public
    #   @example
    #     MLB::Sports.count #=> 23
    #   @return [Integer] the number of items
    # @!method empty?
    #   Checks if the collection is empty
    #   @api public
    #   @example
    #     MLB::Sports.empty? #=> false
    #   @return [Boolean] true if the collection has no items
    # @!method first
    #   Returns the first item in the collection
    #   @api public
    #   @example
    #     MLB::Sports.first #=> #<MLB::Sport id=1 name="Major League Baseball">
    #   @return [Object, nil] the first item or nil if empty
    # @!method last
    #   Returns the last item in the collection
    #   @api public
    #   @example
    #     MLB::Sports.last #=> #<MLB::Sport id=23 name="Winter League">
    #   @return [Object, nil] the last item or nil if empty
    # @!method each
    #   Iterates over each item in the collection
    #   @api public
    #   @example
    #     MLB::Sports.each { |sport| puts sport.name }
    #   @yield [item] yields each item to the block
    #   @return [Enumerator] if no block given
    #   @return [Array] the collection if block given
    # @!method size
    #   Returns the number of items in the collection
    #   @api public
    #   @example
    #     MLB::Sports.size #=> 23
    #   @return [Integer] the number of items
    def_delegators :all, :any?, :count, :empty?, :first, :last, :each
    def_delegator :all, :count, :size

    class << self
      # Returns the API endpoint for this collection
      #
      # @api private
      # @return [String] the API endpoint
      attr_reader :endpoint

      # Returns the collection attribute name
      #
      # @api private
      # @return [Symbol] the collection attribute name
      attr_reader :collection_name

      # Configures the collection with endpoint and item type
      #
      # @api private
      # @param endpoint [String] the API endpoint to fetch from
      # @param item_type [Class] the Shale::Mapper class for individual items
      # @param collection_name [Symbol] the attribute name for the collection
      # @return [void]
      def collection(endpoint:, item_type:, collection_name:)
        @endpoint = endpoint
        @collection_name = collection_name
        attribute collection_name, item_type, collection: true
      end

      # Retrieves all items from this collection
      #
      # @api public
      # @example
      #   MLB::Sports.all #=> [#<MLB::Sport id=1 name="Major League Baseball">, ...]
      # @return [Array] the list of items
      def all
        response = CLIENT.get(endpoint)
        from_json("{\"#{collection_name}\":#{response}}").public_send(collection_name)
      end
    end
  end
end
