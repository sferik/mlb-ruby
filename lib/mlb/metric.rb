require "equalizer"
require "shale"

module MLB
  # Represents a statcast metric
  class Metric < Shale::Mapper
    include Equalizer.new(:metric_id)

    # @!attribute [rw] name
    #   Returns the metric name
    #   @api public
    #   @example
    #     metric.name #=> "launchSpeed"
    #   @return [String] the metric name
    attribute :name, Shale::Type::String

    # @!attribute [rw] metric_id
    #   Returns the unique metric identifier
    #   @api public
    #   @example
    #     metric.metric_id #=> 1
    #   @return [Integer] the unique metric identifier
    attribute :metric_id, Shale::Type::Integer

    # @!attribute [rw] group
    #   Returns the metric group
    #   @api public
    #   @example
    #     metric.group #=> "hitting"
    #   @return [String] the metric group
    attribute :group, Shale::Type::String

    # @!attribute [rw] unit
    #   Returns the measurement unit
    #   @api public
    #   @example
    #     metric.unit #=> "MPH"
    #   @return [String] the measurement unit
    attribute :unit, Shale::Type::String

    json do
      map "name", to: :name
      map "metricId", to: :metric_id
      map "group", to: :group
      map "unit", to: :unit
    end
  end
end
