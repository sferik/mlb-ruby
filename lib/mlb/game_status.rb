require "equalizer"
require "shale"

module MLB
  # Represents a game status
  class GameStatus < Shale::Mapper
    include Equalizer.new(:status_code)

    # @!attribute [rw] abstract_game_state
    #   Returns the high-level game state
    #   @api public
    #   @example
    #     game_status.abstract_game_state #=> "Final"
    #   @return [String] the high-level game state
    attribute :abstract_game_state, Shale::Type::String

    # @!attribute [rw] coded_game_state
    #   Returns the coded game state
    #   @api public
    #   @example
    #     game_status.coded_game_state #=> "F"
    #   @return [String] the coded game state
    attribute :coded_game_state, Shale::Type::String

    # @!attribute [rw] detailed_state
    #   Returns the detailed game state
    #   @api public
    #   @example
    #     game_status.detailed_state #=> "Final"
    #   @return [String] the detailed game state
    attribute :detailed_state, Shale::Type::String

    # @!attribute [rw] status_code
    #   Returns the status code
    #   @api public
    #   @example
    #     game_status.status_code #=> "F"
    #   @return [String] the status code
    attribute :status_code, Shale::Type::String

    # @!attribute [rw] abstract_game_code
    #   Returns the abstract game code
    #   @api public
    #   @example
    #     game_status.abstract_game_code #=> "F"
    #   @return [String] the abstract game code
    attribute :abstract_game_code, Shale::Type::String

    # @!attribute [rw] reason
    #   Returns the reason for the status
    #   @api public
    #   @example
    #     game_status.reason #=> "Rain"
    #   @return [String] the reason for the status
    attribute :reason, Shale::Type::String

    json do
      map "abstractGameState", to: :abstract_game_state
      map "codedGameState", to: :coded_game_state
      map "detailedState", to: :detailed_state
      map "statusCode", to: :status_code
      map "abstractGameCode", to: :abstract_game_code
      map "reason", to: :reason
    end
  end
end
