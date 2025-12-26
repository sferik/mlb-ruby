require "equalizer"
require "shale"

module MLB
  # Represents a baseball statistic type
  class BaseballStat < Shale::Mapper
    include Equalizer.new(:name)

    # @!attribute [rw] name
    #   Returns the internal identifier for the stat
    #   @api public
    #   @example
    #     stat.name #=> "homeRuns"
    #   @return [String] the internal identifier for the stat
    attribute :name, Shale::Type::String

    # @!attribute [rw] lookup_param
    #   Returns the query parameter used in API requests
    #   @api public
    #   @example
    #     stat.lookup_param #=> "hr"
    #   @return [String] the query parameter used in API requests
    attribute :lookup_param, Shale::Type::String

    # @!attribute [rw] is_counting
    #   Returns whether this is a counting stat
    #   @api public
    #   @example
    #     stat.is_counting #=> true
    #   @return [Boolean] whether this is a counting stat
    attribute :is_counting, Shale::Type::Boolean

    # @!attribute [rw] label
    #   Returns the display label for the stat
    #   @api public
    #   @example
    #     stat.label #=> "Home Runs"
    #   @return [String] the display label for the stat
    attribute :label, Shale::Type::String

    # @!attribute [rw] stat_groups
    #   Returns the applicable stat categories
    #   @api public
    #   @example
    #     stat.stat_groups #=> [{"displayName"=>"hitting"}]
    #   @return [Array<Hash>] the applicable stat categories
    attribute :stat_groups, Shale::Type::Value, collection: true

    # @!method counting?
    #   Returns whether this is a counting stat
    #   @api public
    #   @example
    #     stat.counting? #=> true
    #   @return [Boolean, nil] true if this is a counting stat
    alias_method :counting?, :is_counting

    json do
      map "name", to: :name
      map "lookupParam", to: :lookup_param
      map "isCounting", to: :is_counting
      map "label", to: :label
      map "statGroups", to: :stat_groups
    end
  end
end
