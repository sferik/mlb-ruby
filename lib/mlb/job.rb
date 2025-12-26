require "equalizer"
require "shale"
require_relative "player"

module MLB
  # Represents a job/role (umpire, datacaster, etc.)
  class Job < Shale::Mapper
    include Equalizer.new(:person)

    # @!attribute [rw] person
    #   Returns the person holding the job
    #   @api public
    #   @example
    #     job.person #=> #<MLB::Player>
    #   @return [Player] the person
    attribute :person, Player

    # @!attribute [rw] jersey_number
    #   Returns the jersey number
    #   @api public
    #   @example
    #     job.jersey_number #=> "67"
    #   @return [String] the jersey number
    attribute :jersey_number, Shale::Type::String

    # @!attribute [rw] job
    #   Returns the job title
    #   @api public
    #   @example
    #     job.job #=> "Umpire"
    #   @return [String] the job title
    attribute :job, Shale::Type::String

    # @!attribute [rw] job_id
    #   Returns the job identifier
    #   @api public
    #   @example
    #     job.job_id #=> "UMPR"
    #   @return [String] the job identifier
    attribute :job_id, Shale::Type::String

    # @!attribute [rw] title
    #   Returns the title
    #   @api public
    #   @example
    #     job.title #=> "Umpire"
    #   @return [String] the title
    attribute :title, Shale::Type::String

    json do
      map "person", to: :person
      map "jerseyNumber", to: :jersey_number
      map "job", to: :job
      map "jobId", to: :job_id
      map "title", to: :title
    end
  end
end
