require "equalizer"
require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a school in the draft
  class DraftSchool < Shale::Mapper
    # @!attribute [rw] name
    #   Returns the school name
    #   @api public
    #   @example
    #     school.name #=> "Oregon State"
    #   @return [String] the school name
    attribute :name, Shale::Type::String

    # @!attribute [rw] school_class
    #   Returns the class level
    #   @api public
    #   @example
    #     school.school_class #=> "4YR JR"
    #   @return [String] the class level
    attribute :school_class, Shale::Type::String

    # @!attribute [rw] city
    #   Returns the city
    #   @api public
    #   @example
    #     school.city #=> "Corvallis"
    #   @return [String] the city
    attribute :city, Shale::Type::String

    # @!attribute [rw] state
    #   Returns the state
    #   @api public
    #   @example
    #     school.state #=> "OR"
    #   @return [String] the state
    attribute :state, Shale::Type::String

    # @!attribute [rw] country
    #   Returns the country
    #   @api public
    #   @example
    #     school.country #=> "USA"
    #   @return [String] the country
    attribute :country, Shale::Type::String

    json do
      map "name", to: :name
      map "schoolClass", to: :school_class
      map "city", to: :city
      map "state", to: :state
      map "country", to: :country
    end
  end

  # Represents a draft pick
  class DraftPick < Shale::Mapper
    include Equalizer.new(:pick_number, :person)

    # @!attribute [rw] pick_round
    #   Returns the round number
    #   @api public
    #   @example
    #     pick.pick_round #=> "1"
    #   @return [String] the round
    attribute :pick_round, Shale::Type::String

    # @!attribute [rw] pick_number
    #   Returns the overall pick number
    #   @api public
    #   @example
    #     pick.pick_number #=> 1
    #   @return [Integer] the pick number
    attribute :pick_number, Shale::Type::Integer

    # @!attribute [rw] round_pick_number
    #   Returns the pick number within the round
    #   @api public
    #   @example
    #     pick.round_pick_number #=> 1
    #   @return [Integer] the round pick number
    attribute :round_pick_number, Shale::Type::Integer

    # @!attribute [rw] rank
    #   Returns the prospect rank
    #   @api public
    #   @example
    #     pick.rank #=> 1
    #   @return [Integer] the rank
    attribute :rank, Shale::Type::Integer

    # @!attribute [rw] pick_value
    #   Returns the pick slot value
    #   @api public
    #   @example
    #     pick.pick_value #=> "10570600"
    #   @return [String] the pick value
    attribute :pick_value, Shale::Type::String

    # @!attribute [rw] signing_bonus
    #   Returns the signing bonus
    #   @api public
    #   @example
    #     pick.signing_bonus #=> "8950000"
    #   @return [String] the signing bonus
    attribute :signing_bonus, Shale::Type::String

    # @!attribute [rw] person
    #   Returns the drafted player
    #   @api public
    #   @example
    #     pick.person #=> #<MLB::Player>
    #   @return [Player] the player
    attribute :person, Player

    # @!attribute [rw] team
    #   Returns the drafting team
    #   @api public
    #   @example
    #     pick.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] school
    #   Returns the player's school
    #   @api public
    #   @example
    #     pick.school #=> #<MLB::DraftSchool>
    #   @return [DraftSchool] the school
    attribute :school, DraftSchool

    # @!attribute [rw] blurb
    #   Returns the scouting report blurb
    #   @api public
    #   @example
    #     pick.blurb #=> "A native of Sydney..."
    #   @return [String] the blurb
    attribute :blurb, Shale::Type::String

    json do
      map "pickRound", to: :pick_round
      map "pickNumber", to: :pick_number
      map "roundPickNumber", to: :round_pick_number
      map "rank", to: :rank
      map "pickValue", to: :pick_value
      map "signingBonus", to: :signing_bonus
      map "person", to: :person
      map "team", to: :team
      map "school", to: :school
      map "blurb", to: :blurb
    end
  end
end
