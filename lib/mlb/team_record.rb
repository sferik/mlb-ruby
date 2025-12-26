require "equalizer"
require "shale"
require_relative "team"

module MLB
  # Represents a team's league record (wins/losses)
  class LeagueRecord < Shale::Mapper
    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     league_record.wins #=> 94
    #   @return [Integer] the number of wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     league_record.losses #=> 68
    #   @return [Integer] the number of losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] ties
    #   Returns the number of ties
    #   @api public
    #   @example
    #     league_record.ties #=> 0
    #   @return [Integer] the number of ties
    attribute :ties, Shale::Type::Integer

    # @!attribute [rw] pct
    #   Returns the winning percentage
    #   @api public
    #   @example
    #     league_record.pct #=> ".580"
    #   @return [String] the winning percentage
    attribute :pct, Shale::Type::String
  end

  # Represents a team's streak information
  class Streak < Shale::Mapper
    # @!attribute [rw] streak_code
    #   Returns the streak code
    #   @api public
    #   @example
    #     streak.streak_code #=> "W3"
    #   @return [String] the streak code
    attribute :streak_code, Shale::Type::String

    # @!attribute [rw] streak_type
    #   Returns the streak type
    #   @api public
    #   @example
    #     streak.streak_type #=> "wins"
    #   @return [String] the streak type
    attribute :streak_type, Shale::Type::String

    # @!attribute [rw] streak_number
    #   Returns the streak length
    #   @api public
    #   @example
    #     streak.streak_number #=> 3
    #   @return [Integer] the streak length
    attribute :streak_number, Shale::Type::Integer

    # Winning streak type value
    WINS = "wins".freeze
    # Losing streak type value
    LOSSES = "losses".freeze

    # Returns whether this is a winning streak
    #
    # @api public
    # @example
    #   streak.winning? #=> true
    # @return [Boolean] true if this is a winning streak
    def winning? = streak_type.eql?(WINS)

    # Returns whether this is a losing streak
    #
    # @api public
    # @example
    #   streak.losing? #=> false
    # @return [Boolean] true if this is a losing streak
    def losing? = streak_type.eql?(LOSSES)

    json do
      map "streakCode", to: :streak_code
      map "streakType", to: :streak_type
      map "streakNumber", to: :streak_number
    end
  end

  # Represents a team's record in the standings
  class TeamRecord < Shale::Mapper
    include Equalizer.new(:team)

    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     team_record.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] season
    #   Returns the season year
    #   @api public
    #   @example
    #     team_record.season #=> "2024"
    #   @return [String] the season year
    attribute :season, Shale::Type::String

    # @!attribute [rw] streak
    #   Returns the current streak
    #   @api public
    #   @example
    #     team_record.streak #=> #<MLB::Streak>
    #   @return [Streak] the current streak
    attribute :streak, Streak

    # @!attribute [rw] division_rank
    #   Returns the division rank
    #   @api public
    #   @example
    #     team_record.division_rank #=> "1"
    #   @return [String] the division rank
    attribute :division_rank, Shale::Type::String

    # @!attribute [rw] league_rank
    #   Returns the league rank
    #   @api public
    #   @example
    #     team_record.league_rank #=> "1"
    #   @return [String] the league rank
    attribute :league_rank, Shale::Type::String

    attribute :wildcard_rank, Shale::Type::String

    # @!attribute [rw] games_played
    #   Returns the number of games played
    #   @api public
    #   @example
    #     team_record.games_played #=> 162
    #   @return [Integer] the number of games played
    attribute :games_played, Shale::Type::Integer

    # @!attribute [rw] games_back
    #   Returns games behind the division leader
    #   @api public
    #   @example
    #     team_record.games_back #=> "3.0"
    #   @return [String] games behind the division leader
    attribute :games_back, Shale::Type::String

    attribute :wildcard_games_back, Shale::Type::String

    # @!attribute [rw] league_record
    #   Returns the league record
    #   @api public
    #   @example
    #     team_record.league_record #=> #<MLB::LeagueRecord>
    #   @return [LeagueRecord] the league record
    attribute :league_record, LeagueRecord

    # @!attribute [rw] wins
    #   Returns the number of wins
    #   @api public
    #   @example
    #     team_record.wins #=> 94
    #   @return [Integer] the number of wins
    attribute :wins, Shale::Type::Integer

    # @!attribute [rw] losses
    #   Returns the number of losses
    #   @api public
    #   @example
    #     team_record.losses #=> 68
    #   @return [Integer] the number of losses
    attribute :losses, Shale::Type::Integer

    # @!attribute [rw] runs_scored
    #   Returns the runs scored
    #   @api public
    #   @example
    #     team_record.runs_scored #=> 815
    #   @return [Integer] the runs scored
    attribute :runs_scored, Shale::Type::Integer

    # @!attribute [rw] runs_allowed
    #   Returns the runs allowed
    #   @api public
    #   @example
    #     team_record.runs_allowed #=> 668
    #   @return [Integer] the runs allowed
    attribute :runs_allowed, Shale::Type::Integer

    # @!attribute [rw] run_differential
    #   Returns the run differential
    #   @api public
    #   @example
    #     team_record.run_differential #=> 147
    #   @return [Integer] the run differential
    attribute :run_differential, Shale::Type::Integer

    # @!attribute [rw] winning_percentage
    #   Returns the winning percentage
    #   @api public
    #   @example
    #     team_record.winning_percentage #=> ".580"
    #   @return [String] the winning percentage
    attribute :winning_percentage, Shale::Type::String

    # @!attribute [rw] division_champ
    #   Returns whether the team is a division champion
    #   @api public
    #   @example
    #     team_record.division_champ #=> true
    #   @return [Boolean] whether the team is a division champion
    attribute :division_champ, Shale::Type::Boolean

    # @!attribute [rw] division_leader
    #   Returns whether the team leads the division
    #   @api public
    #   @example
    #     team_record.division_leader #=> true
    #   @return [Boolean] whether the team leads the division
    attribute :division_leader, Shale::Type::Boolean

    # @!attribute [rw] clinched
    #   Returns whether the team has clinched a playoff spot
    #   @api public
    #   @example
    #     team_record.clinched #=> true
    #   @return [Boolean] whether the team has clinched
    attribute :clinched, Shale::Type::Boolean

    # @!method division_champ?
    #   Returns whether the team is a division champion
    #   @api public
    #   @example
    #     team_record.division_champ? #=> true
    #   @return [Boolean, nil] whether the team is a division champion
    alias_method :division_champ?, :division_champ

    # @!method division_leader?
    #   Returns whether the team leads the division
    #   @api public
    #   @example
    #     team_record.division_leader? #=> true
    #   @return [Boolean, nil] whether the team leads the division
    alias_method :division_leader?, :division_leader

    # @!method clinched?
    #   Returns whether the team has clinched a playoff spot
    #   @api public
    #   @example
    #     team_record.clinched? #=> true
    #   @return [Boolean, nil] whether the team has clinched
    alias_method :clinched?, :clinched

    json do
      map "team", to: :team
      map "season", to: :season
      map "streak", to: :streak
      map "divisionRank", to: :division_rank
      map "leagueRank", to: :league_rank
      map "wildCardRank", to: :wildcard_rank
      map "gamesPlayed", to: :games_played
      map "gamesBack", to: :games_back
      map "wildCardGamesBack", to: :wildcard_games_back
      map "leagueRecord", to: :league_record
      map "wins", to: :wins
      map "losses", to: :losses
      map "runsScored", to: :runs_scored
      map "runsAllowed", to: :runs_allowed
      map "runDifferential", to: :run_differential
      map "winningPercentage", to: :winning_percentage
      map "divisionChamp", to: :division_champ
      map "divisionLeader", to: :division_leader
      map "clinched", to: :clinched
    end
  end
end
