require "equalizer"
require "shale"
require_relative "team"

module MLB
  # Represents a high/low stat result
  class HighLowResult < Shale::Mapper
    include Equalizer.new(:team, :date, :rank)

    # @!attribute [rw] season
    #   Returns the season
    #   @api public
    #   @example
    #     result.season #=> "2024"
    #   @return [String] the season
    attribute :season, Shale::Type::String

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     result.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] opponent
    #   Returns the opponent team
    #   @api public
    #   @example
    #     result.opponent #=> #<MLB::Team>
    #   @return [Team] the opponent
    attribute :opponent, Team

    # @!attribute [rw] date
    #   Returns the date
    #   @api public
    #   @example
    #     result.date #=> "2024-06-06"
    #   @return [String] the date
    attribute :date, Shale::Type::String

    # @!attribute [rw] is_home
    #   Returns whether the team was at home
    #   @api public
    #   @example
    #     result.home? #=> false
    #   @return [Boolean] whether at home
    attribute :is_home, Shale::Type::Boolean

    # @!attribute [rw] rank
    #   Returns the rank
    #   @api public
    #   @example
    #     result.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # Returns whether the team was at home
    #
    # @api public
    # @example
    #   result.home? #=> false
    # @return [Boolean] whether at home
    def home?
      is_home
    end

    json do
      map "season", to: :season
      map "team", to: :team
      map "opponent", to: :opponent
      map "date", to: :date
      map "isHome", to: :is_home
      map "rank", to: :rank
    end
  end

  # Represents a high/low group
  class HighLowGroup < Shale::Mapper
    # @!attribute [rw] splits
    #   Returns the stat splits
    #   @api public
    #   @example
    #     group.splits #=> [#<MLB::HighLowResult>, ...]
    #   @return [Array<HighLowResult>] the splits
    attribute :splits, HighLowResult, collection: true

    json do
      map "splits", to: :splits
    end
  end

  # Provides methods for fetching high/low stats from the API
  class HighLow < Shale::Mapper
    # @!attribute [rw] high_low_results
    #   Returns the high/low results
    #   @api public
    #   @example
    #     high_low.high_low_results #=> [#<MLB::HighLowGroup>, ...]
    #   @return [Array<HighLowGroup>] the results
    attribute :high_low_results, HighLowGroup, collection: true

    json do
      map "highLowResults", to: :high_low_results
    end

    # Retrieves high/low stats for teams
    #
    # @api public
    # @example Get high/low stats for teams
    #   MLB::HighLow.find(org_type: "team", season: 2024)
    # @param org_type [String] the organization type (team, league, sport)
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<HighLowResult>] the high/low results
    def self.find(org_type:, season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("highLow/#{org_type}?#{Utils.build_query(season:)}")
      from_json(response).high_low_results.flat_map(&:splits)
    end
  end
end
