require "equalizer"
require "shale"

module MLB
  class SeasonDateInfo < Shale::Mapper
    include Equalizer.new(:season_id)

    attribute :season_id, Shale::Type::String
    attribute :pre_season_start_date, Shale::Type::Date
    attribute :pre_season_end_date, Shale::Type::Date
    attribute :season_start_date, Shale::Type::Date
    attribute :spring_start_date, Shale::Type::Date
    attribute :spring_end_date, Shale::Type::Date
    attribute :regular_season_start_date, Shale::Type::Date
    attribute :last_date_1st_half, Shale::Type::Date
    attribute :all_star_date, Shale::Type::Date
    attribute :first_date_2nd_half, Shale::Type::Date
    attribute :regular_season_end_date, Shale::Type::Date
    attribute :post_season_start_date, Shale::Type::Date
    attribute :post_season_end_date, Shale::Type::Date
    attribute :season_end_date, Shale::Type::Date
    attribute :offseason_start_date, Shale::Type::Date
    attribute :off_season_end_date, Shale::Type::Date
    attribute :season_level_gameday_type, Shale::Type::String
    attribute :game_level_gameday_type, Shale::Type::String
    attribute :qualifier_plate_appearances, Shale::Type::Float
    attribute :qualifier_outs_pitched, Shale::Type::Float

    json do
      map "seasonId", to: :season_id
      map "preSeasonStartDate", to: :pre_season_start_date
      map "preSeasonEndDate", to: :pre_season_end_date
      map "seasonStartDate", to: :season_start_date
      map "springStartDate", to: :spring_start_date
      map "springEndDate", to: :spring_end_date
      map "regularSeasonStartDate", to: :regular_season_start_date
      map "lastDate1stHalf", to: :last_date_1st_half
      map "allStarDate", to: :all_star_date
      map "firstDate2ndHalf", to: :first_date_2nd_half
      map "regularSeasonEndDate", to: :regular_season_end_date
      map "postSeasonStartDate", to: :post_season_start_date
      map "postSeasonEndDate", to: :post_season_end_date
      map "seasonEndDate", to: :season_end_date
      map "offseasonStartDate", to: :offseason_start_date
      map "offSeasonEndDate", to: :off_season_end_date
      map "seasonLevelGamedayType", to: :season_level_gameday_type
      map "gameLevelGamedayType", to: :game_level_gameday_type
      map "qualifierPlateAppearances", to: :qualifier_plate_appearances
      map "qualifierOutsPitched", to: :qualifier_outs_pitched
    end
  end
end
