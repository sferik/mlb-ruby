require "equalizer"
require "shale"

module MLB
  # Represents a job type
  class JobType < Shale::Mapper
    include Equalizer.new(:code)

    # @!attribute [rw] code
    #   Returns the job type code
    #   @api public
    #   @example
    #     job_type.code #=> "UMPR"
    #   @return [String] the job type code
    attribute :code, Shale::Type::String

    # @!attribute [rw] job
    #   Returns the job title
    #   @api public
    #   @example
    #     job_type.job #=> "Umpire"
    #   @return [String] the job title
    attribute :job, Shale::Type::String

    # @!attribute [rw] sort_order
    #   Returns the sort order
    #   @api public
    #   @example
    #     job_type.sort_order #=> 1
    #   @return [Integer] the sort order
    attribute :sort_order, Shale::Type::Integer

    json do
      map "code", to: :code
      map "job", to: :job
      map "sortOrder", to: :sort_order
    end
  end
end
