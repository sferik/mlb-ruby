require "shale"
require_relative "standings_record"

module MLB
  # Provides methods for fetching standings from the API
  class Standings < Shale::Mapper
    # Default league IDs for American League (103) and National League (104)
    DEFAULT_LEAGUE_IDS = [103, 104].freeze

    attribute :records, StandingsRecord, collection: true

    json do
      map "records", to: :records
    end

    # Retrieves standings for the given leagues
    #
    # @api public
    # @example Get MLB standings
    #   MLB::Standings.all
    # @example Get standings for a specific season
    #   MLB::Standings.all(season: 2023)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param league_ids [Array<Integer>] league IDs (default: [103, 104] for AL and NL)
    # @return [Array<StandingsRecord>] the standings records
    def self.all(season: nil, league_ids: DEFAULT_LEAGUE_IDS)
      season ||= Utils.current_season
      params = {leagueId: league_ids.join(","), season:}
      response = CLIENT.get("standings?#{Utils.build_query(params)}")
      from_json(response).records
    end

    # Retrieves standings for a specific division
    #
    # @api public
    # @example Get AL East standings
    #   MLB::Standings.find(division: 201)
    # @param division [Division, Integer] the division or division ID
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param league_ids [Array<Integer>] league IDs (default: [103, 104] for AL and NL)
    # @return [StandingsRecord, nil] the standings record for the division
    def self.find(division:, season: nil, league_ids: DEFAULT_LEAGUE_IDS)
      division_id = Utils.extract_id(division)
      all(season:, league_ids:).find { |record| record.division&.id.eql?(division_id) }
    end
  end
end
