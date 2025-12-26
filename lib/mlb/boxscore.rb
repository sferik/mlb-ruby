require "shale"
require_relative "team"
require_relative "boxscore_team_stats"

module MLB
  # Represents one team's boxscore data
  class BoxscoreTeam < Shale::Mapper
    # @!attribute [rw] team
    #   Returns the team
    #   @api public
    #   @example
    #     boxscore_team.team #=> #<MLB::Team>
    #   @return [Team] the team
    attribute :team, Team

    # @!attribute [rw] team_stats
    #   Returns the team statistics
    #   @api public
    #   @example
    #     boxscore_team.team_stats #=> #<MLB::BoxscoreTeamStats>
    #   @return [BoxscoreTeamStats] the team stats
    attribute :team_stats, BoxscoreTeamStats

    json do
      map "team", to: :team
      map "teamStats", to: :team_stats
    end
  end

  # Represents both teams in a boxscore
  class BoxscoreTeams < Shale::Mapper
    # @!attribute [rw] home
    #   Returns the home team data
    #   @api public
    #   @example
    #     boxscore_teams.home #=> #<MLB::BoxscoreTeam>
    #   @return [BoxscoreTeam] the home team
    attribute :home, BoxscoreTeam

    # @!attribute [rw] away
    #   Returns the away team data
    #   @api public
    #   @example
    #     boxscore_teams.away #=> #<MLB::BoxscoreTeam>
    #   @return [BoxscoreTeam] the away team
    attribute :away, BoxscoreTeam

    json do
      map "home", to: :home
      map "away", to: :away
    end
  end

  # Represents a game's boxscore
  class Boxscore < Shale::Mapper
    # @!attribute [rw] teams
    #   Returns the teams data
    #   @api public
    #   @example
    #     boxscore.teams #=> #<MLB::BoxscoreTeams>
    #   @return [BoxscoreTeams] the teams
    attribute :teams, BoxscoreTeams

    json do
      map "teams", to: :teams
    end

    # Retrieves the boxscore for a game
    #
    # @api public
    # @example Get boxscore for a game
    #   MLB::Boxscore.find(game: 745726)
    # @param game [ScheduledGame, Integer] the game or game PK
    # @return [Boxscore] the boxscore
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("game/#{game_pk}/boxscore")
      from_json(response)
    end
  end
end
