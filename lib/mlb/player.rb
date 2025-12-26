require "equalizer"
require "shale"
require_relative "position"
require_relative "handedness"
require_relative "team"

module MLB
  # Represents an MLB player with biographical and career information
  class Player < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the player
    #   @api public
    #   @example
    #     player.id #=> 660271
    #   @return [Integer] the unique identifier for the player
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] full_name
    #   Returns the player's full name
    #   @api public
    #   @example
    #     player.full_name #=> "Shohei Ohtani"
    #   @return [String] the player's full name
    attribute :full_name, Shale::Type::String

    # @!attribute [rw] link
    #   Returns the API link for the player
    #   @api public
    #   @example
    #     player.link #=> "/api/v1/people/660271"
    #   @return [String] the API link for the player
    attribute :link, Shale::Type::String

    # @!attribute [rw] first_name
    #   Returns the player's first name
    #   @api public
    #   @example
    #     player.first_name #=> "Shohei"
    #   @return [String] the player's first name
    attribute :first_name, Shale::Type::String

    # @!attribute [rw] last_name
    #   Returns the player's last name
    #   @api public
    #   @example
    #     player.last_name #=> "Ohtani"
    #   @return [String] the player's last name
    attribute :last_name, Shale::Type::String

    # @!attribute [rw] primary_number
    #   Returns the player's primary jersey number
    #   @api public
    #   @example
    #     player.primary_number #=> 17
    #   @return [Integer] the player's primary jersey number
    attribute :primary_number, Shale::Type::Integer

    # @!attribute [rw] birth_date
    #   Returns the player's date of birth
    #   @api public
    #   @example
    #     player.birth_date #=> #<Date: 1994-07-05>
    #   @return [Date] the player's date of birth
    attribute :birth_date, Shale::Type::Date

    # @!attribute [rw] current_age
    #   Returns the player's current age
    #   @api public
    #   @example
    #     player.current_age #=> 30
    #   @return [Integer] the player's current age
    attribute :current_age, Shale::Type::Integer

    # @!attribute [rw] birth_city
    #   Returns the player's birth city
    #   @api public
    #   @example
    #     player.birth_city #=> "Oshu"
    #   @return [String] the player's birth city
    attribute :birth_city, Shale::Type::String

    # @!attribute [rw] birth_state_province
    #   Returns the player's birth state or province
    #   @api public
    #   @example
    #     player.birth_state_province #=> "Iwate"
    #   @return [String] the player's birth state or province
    attribute :birth_state_province, Shale::Type::String

    # @!attribute [rw] birth_country
    #   Returns the player's birth country
    #   @api public
    #   @example
    #     player.birth_country #=> "Japan"
    #   @return [String] the player's birth country
    attribute :birth_country, Shale::Type::String

    # @!attribute [rw] height
    #   Returns the player's height
    #   @api public
    #   @example
    #     player.height #=> "6' 4\""
    #   @return [String] the player's height
    attribute :height, Shale::Type::String

    # @!attribute [rw] weight
    #   Returns the player's weight in pounds
    #   @api public
    #   @example
    #     player.weight #=> 210
    #   @return [Integer] the player's weight in pounds
    attribute :weight, Shale::Type::Integer

    # @!attribute [rw] active
    #   Returns whether the player is currently active
    #   @api public
    #   @example
    #     player.active #=> true
    #   @return [Boolean] whether the player is currently active
    attribute :active, Shale::Type::Boolean

    # @!attribute [rw] current_team
    #   Returns the player's current team
    #   @api public
    #   @example
    #     player.current_team #=> #<MLB::Team>
    #   @return [Team] the player's current team
    attribute :current_team, Team

    # @!attribute [rw] primary_position
    #   Returns the player's primary position
    #   @api public
    #   @example
    #     player.primary_position #=> #<MLB::Position>
    #   @return [Position] the player's primary position
    attribute :primary_position, Position

    # @!attribute [rw] use_name
    #   Returns the player's preferred name
    #   @api public
    #   @example
    #     player.use_name #=> "Shohei"
    #   @return [String] the player's preferred name
    attribute :use_name, Shale::Type::String

    # @!attribute [rw] middle_name
    #   Returns the player's middle name
    #   @api public
    #   @example
    #     player.middle_name #=> "James"
    #   @return [String] the player's middle name
    attribute :middle_name, Shale::Type::String

    # @!attribute [rw] boxscore_name
    #   Returns the player's name as displayed in boxscores
    #   @api public
    #   @example
    #     player.boxscore_name #=> "Ohtani"
    #   @return [String] the player's name as displayed in boxscores
    attribute :boxscore_name, Shale::Type::String

    # @!attribute [rw] gender
    #   Returns the player's gender
    #   @api public
    #   @example
    #     player.gender #=> "M"
    #   @return [String] the player's gender
    attribute :gender, Shale::Type::String

    # @!attribute [rw] is_player
    #   Returns whether the person is a player
    #   @api public
    #   @example
    #     player.is_player #=> true
    #   @return [Boolean] whether the person is a player
    attribute :is_player, Shale::Type::Boolean

    # @!attribute [rw] is_verified
    #   Returns whether the player's information is verified
    #   @api public
    #   @example
    #     player.is_verified #=> true
    #   @return [Boolean] whether the player's information is verified
    attribute :is_verified, Shale::Type::Boolean

    # @!attribute [rw] draft_year
    #   Returns the year the player was drafted
    #   @api public
    #   @example
    #     player.draft_year #=> 2018
    #   @return [Integer] the year the player was drafted
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] mlb_debut_date
    #   Returns the date of the player's MLB debut
    #   @api public
    #   @example
    #     player.mlb_debut_date #=> #<Date: 2018-03-29>
    #   @return [Date] the date of the player's MLB debut
    attribute :mlb_debut_date, Shale::Type::Date

    # @!attribute [rw] bat_side
    #   Returns the player's batting side
    #   @api public
    #   @example
    #     player.bat_side #=> #<MLB::Handedness>
    #   @return [Handedness] the player's batting side
    attribute :bat_side, Handedness

    # @!attribute [rw] pitch_hand
    #   Returns the player's pitching hand
    #   @api public
    #   @example
    #     player.pitch_hand #=> #<MLB::Handedness>
    #   @return [Handedness] the player's pitching hand
    attribute :pitch_hand, Handedness

    # @!method verified?
    #   Returns whether the player is verified
    #   @api public
    #   @example
    #     player.verified? #=> true
    #   @return [Boolean] whether the player is verified
    alias_method :verified?, :is_verified

    # @!method player?
    #   Returns whether the person is a player
    #   @api public
    #   @example
    #     player.player? #=> true
    #   @return [Boolean] whether the person is a player
    alias_method :player?, :is_player

    # @!method active?
    #   Returns whether the player is active
    #   @api public
    #   @example
    #     player.active? #=> true
    #   @return [Boolean] whether the player is active
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
