require "shale"
require_relative "team"
require_relative "venue"
require_relative "player"

module MLB
  # Represents game date/time information
  class GameDateTime < Shale::Mapper
    # @!attribute [rw] date_time
    #   Returns the game date and time
    #   @api public
    #   @example
    #     datetime.date_time #=> "2024-10-01T23:08:00Z"
    #   @return [String] the game date and time
    attribute :date_time, Shale::Type::String

    # @!attribute [rw] original_date
    #   Returns the original scheduled date
    #   @api public
    #   @example
    #     datetime.original_date #=> "2024-10-01"
    #   @return [String] the original date
    attribute :original_date, Shale::Type::String

    # @!attribute [rw] day_night
    #   Returns day or night game indicator
    #   @api public
    #   @example
    #     datetime.day_night #=> "night"
    #   @return [String] day or night
    attribute :day_night, Shale::Type::String

    # @!attribute [rw] time
    #   Returns the game time
    #   @api public
    #   @example
    #     datetime.time #=> "7:08"
    #   @return [String] the time
    attribute :time, Shale::Type::String

    # @!attribute [rw] am_pm
    #   Returns AM or PM indicator
    #   @api public
    #   @example
    #     datetime.am_pm #=> "PM"
    #   @return [String] AM or PM
    attribute :am_pm, Shale::Type::String

    # Day game indicator value
    DAY = "day".freeze
    # Night game indicator value
    NIGHT = "night".freeze
    # AM indicator value
    AM = "AM".freeze
    # PM indicator value
    PM = "PM".freeze

    # Returns whether this is a day game
    #
    # @api public
    # @example
    #   datetime.day? #=> false
    # @return [Boolean] true if the game is a day game
    def day? = day_night.eql?(DAY)

    # Returns whether this is a night game
    #
    # @api public
    # @example
    #   datetime.night? #=> true
    # @return [Boolean] true if the game is a night game
    def night? = day_night.eql?(NIGHT)

    # Returns whether this game starts in the morning (AM)
    #
    # @api public
    # @example
    #   datetime.am? #=> false
    # @return [Boolean] true if the game starts in the morning
    def am? = am_pm.eql?(AM)

    # Returns whether this game starts in the afternoon/evening (PM)
    #
    # @api public
    # @example
    #   datetime.pm? #=> true
    # @return [Boolean] true if the game starts in the afternoon/evening
    def pm? = am_pm.eql?(PM)

    json do
      map "dateTime", to: :date_time
      map "originalDate", to: :original_date
      map "dayNight", to: :day_night
      map "time", to: :time
      map "ampm", to: :am_pm
    end
  end

  # Represents the teams playing in a game
  class GameTeams < Shale::Mapper
    # @!attribute [rw] away
    #   Returns the away team
    #   @api public
    #   @example
    #     teams.away #=> #<MLB::Team>
    #   @return [Team] the away team
    attribute :away, Team

    # @!attribute [rw] home
    #   Returns the home team
    #   @api public
    #   @example
    #     teams.home #=> #<MLB::Team>
    #   @return [Team] the home team
    attribute :home, Team

    json do
      map "away", to: :away
      map "home", to: :home
    end
  end

  # Represents the game metadata
  class GameData < Shale::Mapper
    # @!attribute [rw] datetime
    #   Returns the game date/time info
    #   @api public
    #   @example
    #     data.datetime #=> #<MLB::GameDateTime>
    #   @return [GameDateTime] the date/time info
    attribute :datetime, GameDateTime

    # @!attribute [rw] teams
    #   Returns the teams
    #   @api public
    #   @example
    #     data.teams #=> #<MLB::GameTeams>
    #   @return [GameTeams] the teams
    attribute :teams, GameTeams

    # @!attribute [rw] venue
    #   Returns the venue
    #   @api public
    #   @example
    #     data.venue #=> #<MLB::Venue>
    #   @return [Venue] the venue
    attribute :venue, Venue

    json do
      map "datetime", to: :datetime
      map "teams", to: :teams
      map "venue", to: :venue
    end
  end
end
