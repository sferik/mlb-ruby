require "equalizer"
require "shale"
require_relative "position"
require_relative "handedness"
require_relative "team"

module MLB
  class Player < Shale::Mapper
    include Equalizer.new(:id)

    attribute :id, Shale::Type::Integer
    attribute :full_name, Shale::Type::String
    attribute :link, Shale::Type::String
    attribute :first_name, Shale::Type::String
    attribute :last_name, Shale::Type::String
    attribute :primary_number, Shale::Type::Integer
    attribute :birth_date, Shale::Type::Date
    attribute :current_age, Shale::Type::Integer
    attribute :birth_city, Shale::Type::String
    attribute :birth_state_province, Shale::Type::String
    attribute :birth_country, Shale::Type::String
    attribute :height, Shale::Type::String
    attribute :weight, Shale::Type::Integer
    attribute :active, Shale::Type::Boolean
    attribute :current_team, Team
    attribute :primary_position, Position
    attribute :use_name, Shale::Type::String
    attribute :middle_name, Shale::Type::String
    attribute :boxscore_name, Shale::Type::String
    attribute :gender, Shale::Type::String
    attribute :is_player, Shale::Type::Boolean
    attribute :is_verified, Shale::Type::Boolean
    attribute :draft_year, Shale::Type::Integer
    attribute :mlb_debut_date, Shale::Type::Date
    attribute :bat_side, Handedness
    attribute :pitch_hand, Handedness

    alias_method :verified?, :is_verified
    alias_method :player?, :is_player
    alias_method :active?, :active

    json do
      map "id", to: :id
      map "fullName", to: :full_name
      map "nameFirstLast", to: :full_name
      map "link", to: :link
      map "firstName", to: :first_name
      map "lastName", to: :last_name
      map "primaryNumber", to: :primary_number
      map "birthDate", to: :birth_date
      map "currentAge", to: :current_age
      map "birthCity", to: :birth_city
      map "birthStateProvince", to: :birth_state_province
      map "birthCountry", to: :birth_country
      map "height", to: :height
      map "weight", to: :weight
      map "active", to: :active
      map "currentTeam", to: :current_team
      map "primaryPosition", to: :primary_position
      map "useName", to: :use_name
      map "middleName", to: :middle_name
      map "boxscoreName", to: :boxscore_name
      map "gender", to: :gender
      map "isPlayer", to: :is_player
      map "isVerified", to: :is_verified
      map "draftYear", to: :draft_year
      map "mlbDebutDate", to: :mlb_debut_date
      map "batSide", to: :bat_side
      map "pitchHand", to: :pitch_hand
    end
  end
end
