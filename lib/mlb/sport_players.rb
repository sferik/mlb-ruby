require "shale"
require_relative "player"

module MLB
  # Provides methods for fetching players for a sport from the API
  class SportPlayers < Shale::Mapper
    attribute :people, Player, collection: true

    json do
      map "people", to: :people
    end

    # Retrieves all players for a sport
    #
    # @api public
    # @example Get all MLB players for a season
    #   MLB::SportPlayers.all(season: 2024)
    # @example Get all players with a sport object
    #   MLB::SportPlayers.all(season: 2024, sport: Sport.new(id: 1))
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<Player>] the players
    def self.all(season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      sport_id = Utils.extract_id(sport)
      response = CLIENT.get("sports/#{sport_id}/players?#{Utils.build_query(season:)}")
      from_json(response).people
    end
  end
end
