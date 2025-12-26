require_relative "collection"
require_relative "hit_trajectory"

module MLB
  # Provides methods for fetching hit trajectories from the API
  #
  # @example Fetch all hit trajectories
  #   MLB::HitTrajectories.all #=> [#<MLB::HitTrajectory>, ...]
  class HitTrajectories < Collection
    collection endpoint: "hitTrajectories", item_type: HitTrajectory, collection_name: :hit_trajectories
  end
end
