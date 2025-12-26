require "shale"
require "equalizer"

module MLB
  # Represents uniform color information
  class UniformColor < Shale::Mapper
    attribute :name, Shale::Type::String
    attribute :hex, Shale::Type::String

    json do
      map "name", to: :name
      map "hex", to: :hex
    end
  end

  # Represents uniform asset information
  class UniformAsset < Shale::Mapper
    attribute :cap, Shale::Type::String
    attribute :jersey, Shale::Type::String

    json do
      map "cap", to: :cap
      map "jersey", to: :jersey
    end
  end

  # Represents a team's uniform information
  class UniformInfo < Shale::Mapper
    include Equalizer.new(:team_id, :uniform_type)

    attribute :team_id, Shale::Type::Integer
    attribute :uniform_type, Shale::Type::String
    attribute :jersey_color, UniformColor
    attribute :cap_color, UniformColor
    attribute :assets, UniformAsset

    json do
      map "teamId", to: :team_id
      map "uniformType", to: :uniform_type
      map "jerseyColor", to: :jersey_color
      map "capColor", to: :cap_color
      map "assets", to: :assets
    end
  end

  # Represents game uniform information for both teams
  class GameUniforms < Shale::Mapper
    attribute :away, UniformInfo
    attribute :home, UniformInfo

    json do
      map "away", to: :away
      map "home", to: :home
    end

    # Retrieves uniform information for a game
    #
    # @api public
    # @example Get uniforms for a game
    #   MLB::GameUniforms.find(game: 745571)
    # @example Get uniforms using a ScheduledGame object
    #   MLB::GameUniforms.find(game: scheduled_game)
    # @param game [Integer, ScheduledGame] the game ID or game object
    # @return [GameUniforms] the game uniforms
    def self.find(game:)
      game_pk = game.respond_to?(:game_pk) ? game.game_pk : game
      response = CLIENT.get("uniforms/game?#{Utils.build_query(gamePk: game_pk)}")
      from_json(response)
    end
  end

  # Represents team uniform collection
  class TeamUniforms < Shale::Mapper
    attribute :uniforms, UniformInfo, collection: true

    json do
      map "uniforms", to: :uniforms
    end

    # Retrieves uniform information for a team
    #
    # @api public
    # @example Get uniforms for a team
    #   MLB::TeamUniforms.find(team: 147)
    # @example Get uniforms using a Team object
    #   MLB::TeamUniforms.find(team: team)
    # @param team [Integer, Team] the team ID or team object
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<UniformInfo>] the team uniforms
    def self.find(team:, season: nil)
      season ||= Utils.current_season
      params = {teamId: Utils.extract_id(team), season:}
      response = CLIENT.get("uniforms/team?#{Utils.build_query(params)}")
      from_json(response).uniforms
    end
  end
end
