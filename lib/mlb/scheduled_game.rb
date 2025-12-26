require "equalizer"
require "shale"
require_relative "game_status"
require_relative "team"
require_relative "venue"

module MLB
  # Represents a team's information in a scheduled game
  class ScheduledGameTeam < Shale::Mapper
    include Equalizer.new(:team)

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     scheduled_game_team.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] score
    #   Returns the team's score
    #   @api public
    #   @example
    #     scheduled_game_team.score #=> 5
    #   @return [Integer] the team's score
    attribute :score, Shale::Type::Integer

    # @!attribute [rw] is_winner
    #   Returns whether this team won the game
    #   @api public
    #   @example
    #     scheduled_game_team.is_winner #=> true
    #   @return [Boolean] whether this team won the game
    attribute :is_winner, Shale::Type::Boolean

    # @!method winner?
    #   Returns whether this team won the game
    #   @api public
    #   @example
    #     scheduled_game_team.winner? #=> true
    #   @return [Boolean, nil] whether this team won the game
    alias_method :winner?, :is_winner

    json do
      map "team", to: :team
      map "score", to: :score
      map "isWinner", to: :is_winner
    end
  end

  # Represents the teams playing in a scheduled game
  class ScheduledGameTeams < Shale::Mapper
    # @!attribute [rw] away
    #   Returns the away team information
    #   @api public
    #   @example
    #     teams.away #=> #<MLB::ScheduledGameTeam>
    #   @return [ScheduledGameTeam] the away team information
    attribute :away, ScheduledGameTeam

    # @!attribute [rw] home
    #   Returns the home team information
    #   @api public
    #   @example
    #     teams.home #=> #<MLB::ScheduledGameTeam>
    #   @return [ScheduledGameTeam] the home team information
    attribute :home, ScheduledGameTeam
  end

  # Represents a scheduled game from the MLB Stats API
  class ScheduledGame < Shale::Mapper
    include Equalizer.new(:game_pk)

    # @!attribute [rw] game_pk
    #   Returns the unique game identifier
    #   @api public
    #   @example
    #     scheduled_game.game_pk #=> 744834
    #   @return [Integer] the unique game identifier
    attribute :game_pk, Shale::Type::Integer

    # @!attribute [rw] link
    #   Returns the API link for the game feed
    #   @api public
    #   @example
    #     scheduled_game.link #=> "/api/v1.1/game/744834/feed/live"
    #   @return [String] the API link for the game feed
    attribute :link, Shale::Type::String

    # @!attribute [rw] game_type
    #   Returns the game type code
    #   @api public
    #   @example
    #     scheduled_game.game_type #=> "R"
    #   @return [String] the game type code
    attribute :game_type, Shale::Type::String

    # @!attribute [rw] season
    #   Returns the season year
    #   @api public
    #   @example
    #     scheduled_game.season #=> "2024"
    #   @return [String] the season year
    attribute :season, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date and time
    #   @api public
    #   @example
    #     scheduled_game.game_date #=> "2024-07-04T15:05:00Z"
    #   @return [String] the game date and time
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] official_date
    #   Returns the official game date
    #   @api public
    #   @example
    #     scheduled_game.official_date #=> #<Date: 2024-07-04>
    #   @return [Date] the official game date
    attribute :official_date, Shale::Type::Date

    # @!attribute [rw] status
    #   Returns the game status
    #   @api public
    #   @example
    #     scheduled_game.status #=> #<MLB::GameStatus>
    #   @return [GameStatus] the game status
    attribute :status, GameStatus

    # @!attribute [rw] teams
    #   Returns the teams playing
    #   @api public
    #   @example
    #     scheduled_game.teams #=> #<MLB::ScheduledGameTeams>
    #   @return [ScheduledGameTeams] the teams playing
    attribute :teams, ScheduledGameTeams

    # @!attribute [rw] venue
    #   Returns the game venue
    #   @api public
    #   @example
    #     scheduled_game.venue #=> #<MLB::Venue>
    #   @return [Venue] the game venue
    attribute :venue, Venue

    # @!attribute [rw] is_tie
    #   Returns whether the game ended in a tie
    #   @api public
    #   @example
    #     scheduled_game.is_tie #=> false
    #   @return [Boolean] whether the game ended in a tie
    attribute :is_tie, Shale::Type::Boolean

    # @!attribute [rw] game_number
    #   Returns the game number (for doubleheaders)
    #   @api public
    #   @example
    #     scheduled_game.game_number #=> 1
    #   @return [Integer] the game number
    attribute :game_number, Shale::Type::Integer

    # @!attribute [rw] double_header
    #   Returns the doubleheader indicator
    #   @api public
    #   @example
    #     scheduled_game.double_header #=> "N"
    #   @return [String] the doubleheader indicator
    attribute :double_header, Shale::Type::String

    # @!attribute [rw] day_night
    #   Returns whether the game is a day or night game
    #   @api public
    #   @example
    #     scheduled_game.day_night #=> "day"
    #   @return [String] the day/night indicator
    attribute :day_night, Shale::Type::String

    # @!attribute [rw] scheduled_innings
    #   Returns the number of scheduled innings
    #   @api public
    #   @example
    #     scheduled_game.scheduled_innings #=> 9
    #   @return [Integer] the number of scheduled innings
    attribute :scheduled_innings, Shale::Type::Integer

    # @!attribute [rw] series_description
    #   Returns the series description
    #   @api public
    #   @example
    #     scheduled_game.series_description #=> "Regular Season"
    #   @return [String] the series description
    attribute :series_description, Shale::Type::String

    # @!attribute [rw] games_in_series
    #   Returns the number of games in the series
    #   @api public
    #   @example
    #     scheduled_game.games_in_series #=> 4
    #   @return [Integer] the number of games in the series
    attribute :games_in_series, Shale::Type::Integer

    # @!attribute [rw] series_game_number
    #   Returns the game number within the series
    #   @api public
    #   @example
    #     scheduled_game.series_game_number #=> 1
    #   @return [Integer] the game number within the series
    attribute :series_game_number, Shale::Type::Integer

    # @!method tie?
    #   Returns whether the game ended in a tie
    #   @api public
    #   @example
    #     scheduled_game.tie? #=> false
    #   @return [Boolean, nil] whether the game ended in a tie
    alias_method :tie?, :is_tie

    # Day game indicator value
    DAY = "day".freeze
    # Night game indicator value
    NIGHT = "night".freeze
    # Doubleheader indicator values that indicate a doubleheader
    DOUBLE_HEADER_VALUES = %w[Y S].freeze
    # Game type: Regular Season
    GAME_TYPE_REGULAR = "R".freeze
    # Game type: Spring Training
    GAME_TYPE_SPRING = "S".freeze
    # Game type: Exhibition
    GAME_TYPE_EXHIBITION = "E".freeze
    # Game type: All-Star Game
    GAME_TYPE_ALL_STAR = "A".freeze
    # Game type codes that indicate postseason games
    POSTSEASON_GAME_TYPES = %w[F D L W].freeze

    # Returns whether this is a day game
    #
    # @api public
    # @example
    #   scheduled_game.day? #=> true
    # @return [Boolean] true if the game is a day game
    def day? = day_night.eql?(DAY)

    # Returns whether this is a night game
    #
    # @api public
    # @example
    #   scheduled_game.night? #=> false
    # @return [Boolean] true if the game is a night game
    def night? = day_night.eql?(NIGHT)

    # Returns whether this game is part of a doubleheader
    #
    # @api public
    # @example
    #   scheduled_game.double_header? #=> false
    # @return [Boolean] true if the game is part of a doubleheader
    # mutant:disable - .to_s is for type safety; include?(nil) returns false anyway
    def double_header? = DOUBLE_HEADER_VALUES.include?(double_header.to_s)

    # Returns whether this is a regular season game
    #
    # @api public
    # @example
    #   scheduled_game.regular_season? #=> true
    # @return [Boolean] true if the game is a regular season game
    def regular_season? = game_type.eql?(GAME_TYPE_REGULAR)

    # Returns whether this is a spring training game
    #
    # @api public
    # @example
    #   scheduled_game.spring_training? #=> false
    # @return [Boolean] true if the game is a spring training game
    def spring_training? = game_type.eql?(GAME_TYPE_SPRING)

    # Returns whether this is an exhibition game
    #
    # @api public
    # @example
    #   scheduled_game.exhibition? #=> false
    # @return [Boolean] true if the game is an exhibition game
    def exhibition? = game_type.eql?(GAME_TYPE_EXHIBITION)

    # Returns whether this is an All-Star game
    #
    # @api public
    # @example
    #   scheduled_game.all_star? #=> false
    # @return [Boolean] true if the game is an All-Star game
    def all_star? = game_type.eql?(GAME_TYPE_ALL_STAR)

    # Returns whether this is a postseason game
    #
    # @api public
    # @example
    #   scheduled_game.postseason? #=> false
    # @return [Boolean] true if the game is a postseason game
    # mutant:disable - .to_s is for type safety; include?(nil) returns false anyway
    def postseason? = POSTSEASON_GAME_TYPES.include?(game_type.to_s)

    json do
      map "gamePk", to: :game_pk
      map "link", to: :link
      map "gameType", to: :game_type
      map "season", to: :season
      map "gameDate", to: :game_date
      map "officialDate", to: :official_date
      map "status", to: :status
      map "teams", to: :teams
      map "venue", to: :venue
      map "isTie", to: :is_tie
      map "gameNumber", to: :game_number
      map "doubleHeader", to: :double_header
      map "dayNight", to: :day_night
      map "scheduledInnings", to: :scheduled_innings
      map "seriesDescription", to: :series_description
      map "gamesInSeries", to: :games_in_series
      map "seriesGameNumber", to: :series_game_number
    end
  end
end
