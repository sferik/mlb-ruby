require "equalizer"
require "shale"
require_relative "league"
require_relative "sport"

module MLB
  # Represents a season
  class Season < Shale::Mapper
    include Comparable
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :has_wildcard, Shale::Type::Boolean
    attribute :preseason_start_date, Shale::Type::Date
    attribute :preseason_end_date, Shale::Type::Date
    attribute :season_start_date, Shale::Type::Date
    attribute :spring_start_date, Shale::Type::Date
    attribute :spring_end_date, Shale::Type::Date
    attribute :regular_season_start_date, Shale::Type::Date
    attribute :last_date_first_half, Shale::Type::Date
    attribute :all_star_date, Shale::Type::Date
    attribute :first_date_second_half, Shale::Type::Date
    attribute :regular_season_end_date, Shale::Type::Date
    attribute :postseason_start_date, Shale::Type::Date
    attribute :postseason_end_date, Shale::Type::Date
    attribute :season_end_date, Shale::Type::Date
    attribute :offseason_start_date, Shale::Type::Date
    attribute :offseason_end_date, Shale::Type::Date
    attribute :season_level_gameday_type, Shale::Type::String
    attribute :game_level_gameday_type, Shale::Type::String
    attribute :qualifier_plate_appearances, Shale::Type::Float
    attribute :qualifier_outs_pitched, Shale::Type::Float

    # Returns whether the season has a wild card
    #
    # @api public
    # @example
    #   season.wildcard?
    # @return [Boolean, nil] true if the season has a wild card
    alias_method :wildcard?, :has_wildcard

    json do
      map "seasonId", to: :id
      map "hasWildcard", to: :has_wildcard
      map "preSeasonStartDate", to: :preseason_start_date
      map "preSeasonEndDate", to: :preseason_end_date
      map "seasonStartDate", to: :season_start_date
      map "springStartDate", to: :spring_start_date
      map "springEndDate", to: :spring_end_date
      map "regularSeasonStartDate", to: :regular_season_start_date
      map "lastDate1stHalf", to: :last_date_first_half
      map "allStarDate", to: :all_star_date
      map "firstDate2ndHalf", to: :first_date_second_half
      map "regularSeasonEndDate", to: :regular_season_end_date
      map "postSeasonStartDate", to: :postseason_start_date
      map "postSeasonEndDate", to: :postseason_end_date
      map "seasonEndDate", to: :season_end_date
      map "offseasonStartDate", to: :offseason_start_date
      map "offSeasonEndDate", to: :offseason_end_date
      map "seasonLevelGamedayType", to: :season_level_gameday_type
      map "gameLevelGamedayType", to: :game_level_gameday_type
      map "qualifierPlateAppearances", to: :qualifier_plate_appearances
      map "qualifierOutsPitched", to: :qualifier_outs_pitched
    end

    # Compares seasons by ID (year)
    #
    # @api public
    # @example
    #   season1 <=> season2
    # @param other [Season] the season to compare with
    # @return [Integer, nil] -1, 0, or 1 for comparison
    def <=>(other)
      id <=> other.id
    end
  end
end
