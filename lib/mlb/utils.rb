require "uri"

module MLB
  # Utility methods and constants shared across the MLB gem
  module Utils
    # Default sport ID for MLB (Major League Baseball)
    DEFAULT_SPORT_ID = 1

    class << self
      # Returns the current MLB season year
      #
      # @api public
      # @example
      #   Utils.current_season #=> 2024
      # @return [Integer] the current year
      def current_season
        Time.now.year
      end

      # Extracts the ID from an object or returns the value as-is
      #
      # @api private
      # @example With a model object
      #   Utils.extract_id(team) #=> 147
      # @example With a raw ID
      #   Utils.extract_id(147) #=> 147
      # @param object [#id, Integer, String] an object with an id method or an ID value
      # @return [Integer, String] the extracted ID
      def extract_id(object)
        object.respond_to?(:id) ? object.id : object
      end

      # Builds a URL-encoded query string from parameters
      #
      # @api private
      # @example
      #   Utils.build_query(season: 2024, sportId: 1) #=> "season=2024&sportId=1"
      # @param params [Hash] the parameters to encode
      # @return [String] the URL-encoded query string
      def build_query(params)
        URI.encode_www_form(params)
      end
    end
  end
end
