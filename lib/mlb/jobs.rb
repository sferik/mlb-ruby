require "shale"
require_relative "job"

module MLB
  # Provides methods for fetching job data from the API
  class Jobs < Shale::Mapper
    # @!attribute [rw] roster
    #   Returns the job roster
    #   @api public
    #   @example
    #     jobs.roster #=> [#<MLB::Job>, ...]
    #   @return [Array<Job>] the job roster
    attribute :roster, Job, collection: true

    json do
      map "roster", to: :roster
    end

    # Retrieves all umpires
    #
    # @api public
    # @example Get all umpires for the current season
    #   MLB::Jobs.umpires
    # @example Get umpires for a specific season
    #   MLB::Jobs.umpires(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Job>] the umpires
    def self.umpires(season: nil)
      fetch_jobs("jobs/umpires", season:)
    end

    # Retrieves all datacasters
    #
    # @api public
    # @example Get all datacasters for the current season
    #   MLB::Jobs.datacasters
    # @example Get datacasters for a specific season
    #   MLB::Jobs.datacasters(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Job>] the datacasters
    def self.datacasters(season: nil)
      fetch_jobs("jobs/datacasters", season:)
    end

    # Retrieves all official scorers
    #
    # @api public
    # @example Get all official scorers for the current season
    #   MLB::Jobs.official_scorers
    # @example Get official scorers for a specific season
    #   MLB::Jobs.official_scorers(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Job>] the official scorers
    def self.official_scorers(season: nil)
      fetch_jobs("jobs/officialScorers", season:)
    end

    # Retrieves games for a specific umpire
    #
    # @api public
    # @example Get games for an umpire
    #   MLB::Jobs.umpire_games(umpire: 427127, season: 2024)
    # @param umpire [Job, Integer] the umpire or umpire ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Job>] the umpire's game assignments
    def self.umpire_games(umpire:, season: nil)
      umpire_id = umpire.respond_to?(:person) ? umpire.person.id : umpire
      fetch_jobs("jobs/umpires/games/#{umpire_id}", season:)
    end

    class << self
      private

      # Fetches jobs from the specified endpoint
      #
      # @api private
      # @param endpoint [String] the API endpoint path
      # @param season [Integer, nil] the season year
      # @return [Array<Job>] the jobs
      def fetch_jobs(endpoint, season:)
        season ||= Utils.current_season
        response = CLIENT.get("#{endpoint}?#{Utils.build_query(season:)}")
        from_json(response).roster
      end
    end
  end
end
