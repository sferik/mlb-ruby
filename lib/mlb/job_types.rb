require_relative "collection"
require_relative "job_type"

module MLB
  # Provides methods for fetching job types from the API
  #
  # @example Fetch all job types
  #   MLB::JobTypes.all #=> [#<MLB::JobType>, ...]
  class JobTypes < Collection
    collection endpoint: "jobTypes", item_type: JobType, collection_name: :job_types
  end
end
