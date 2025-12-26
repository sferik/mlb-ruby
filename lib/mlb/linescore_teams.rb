require "shale"
require_relative "inning_score"

module MLB
  # Represents one team's linescore totals
  class LinescoreTeam < Shale::Mapper
    # @!attribute [rw] runs
    #   Returns total runs
    #   @api public
    #   @example
    #     linescore_team.runs #=> 8
    #   @return [Integer] the runs
    attribute :runs, Shale::Type::Integer

    # @!attribute [rw] hits
    #   Returns total hits
    #   @api public
    #   @example
    #     linescore_team.hits #=> 9
    #   @return [Integer] the hits
    attribute :hits, Shale::Type::Integer

    # @!attribute [rw] errors
    #   Returns total errors
    #   @api public
    #   @example
    #     linescore_team.errors #=> 0
    #   @return [Integer] the errors
    attribute :errors, Shale::Type::Integer

    # @!attribute [rw] left_on_base
    #   Returns total left on base
    #   @api public
    #   @example
    #     linescore_team.left_on_base #=> 5
    #   @return [Integer] the left on base
    attribute :left_on_base, Shale::Type::Integer

    # @!attribute [rw] is_winner
    #   Returns whether this team won
    #   @api public
    #   @example
    #     linescore_team.winner? #=> true
    #   @return [Boolean] whether this team won
    attribute :is_winner, Shale::Type::Boolean

    # Returns whether this team won
    #
    # @api public
    # @example
    #   linescore_team.winner? #=> true
    # @return [Boolean] whether this team won
    def winner?
      is_winner
    end

    json do
      map "runs", to: :runs
      map "hits", to: :hits
      map "errors", to: :errors
      map "leftOnBase", to: :left_on_base
      map "isWinner", to: :is_winner
    end
  end

  # Represents both teams' linescore totals
  class LinescoreTeams < Shale::Mapper
    # @!attribute [rw] home
    #   Returns the home team's totals
    #   @api public
    #   @example
    #     linescore_teams.home #=> #<MLB::LinescoreTeam>
    #   @return [LinescoreTeam] the home team
    attribute :home, LinescoreTeam

    # @!attribute [rw] away
    #   Returns the away team's totals
    #   @api public
    #   @example
    #     linescore_teams.away #=> #<MLB::LinescoreTeam>
    #   @return [LinescoreTeam] the away team
    attribute :away, LinescoreTeam

    json do
      map "home", to: :home
      map "away", to: :away
    end
  end
end
