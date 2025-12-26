require "shale"
require_relative "scheduled_game"

module MLB
  # Represents postseason series information
  class SeriesInfo < Shale::Mapper
    attribute :id, Shale::Type::String
    attribute :sort_number, Shale::Type::Integer
    attribute :game_type, Shale::Type::String

    json do
      map "id", to: :id
      map "sortNumber", to: :sort_number
      map "gameType", to: :game_type
    end
  end

  # Represents a postseason series with games
  class PostseasonSeriesEntry < Shale::Mapper
    attribute :series, SeriesInfo
    attribute :total_games, Shale::Type::Integer
    attribute :games, ScheduledGame, collection: true

    json do
      map "series", to: :series
      map "totalGames", to: :total_games
      map "games", to: :games
    end
  end

  # Provides methods for fetching postseason series from the API
  class PostseasonSeries < Shale::Mapper
    attribute :series, PostseasonSeriesEntry, collection: true

    json do
      map "series", to: :series
    end

    # Retrieves postseason series for a season
    #
    # @api public
    # @example Get postseason series for a season
    #   MLB::PostseasonSeries.all(season: 2024)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @param sport [Integer, Sport] the sport ID or Sport object
    # @return [Array<PostseasonSeriesEntry>] the postseason series
    def self.all(season: nil, sport: Utils::DEFAULT_SPORT_ID)
      season ||= Utils.current_season
      params = {season:, sportId: Utils.extract_id(sport)}
      response = CLIENT.get("schedule/postseason/series?#{Utils.build_query(params)}")
      from_json(response).series
    end
  end
end
