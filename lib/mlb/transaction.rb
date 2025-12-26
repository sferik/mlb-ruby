require "equalizer"
require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a player transaction (trade, signing, etc.)
  class Transaction < Shale::Mapper
    include Equalizer.new(:id)

    # @!attribute [rw] id
    #   Returns the unique identifier for the transaction
    #   @api public
    #   @example
    #     transaction.id #=> 12345
    #   @return [Integer] the unique identifier for the transaction
    attribute :id, Shale::Type::Integer

    # @!attribute [rw] player
    #   Returns the player involved in the transaction
    #   @api public
    #   @example
    #     transaction.player #=> #<MLB::Player>
    #   @return [Player] the player involved in the transaction
    attribute :player, Player

    # @!attribute [rw] from_team
    #   Returns the team the player is leaving
    #   @api public
    #   @example
    #     transaction.from_team #=> #<MLB::Team>
    #   @return [Team, nil] the team the player is leaving
    attribute :from_team, Team, default: nil

    # @!attribute [rw] to_team
    #   Returns the team the player is joining
    #   @api public
    #   @example
    #     transaction.to_team #=> #<MLB::Team>
    #   @return [Team] the team the player is joining
    attribute :to_team, Team

    # @!attribute [rw] date
    #   Returns the date of the transaction
    #   @api public
    #   @example
    #     transaction.date #=> #<Date: 2024-01-15>
    #   @return [Date] the date of the transaction
    attribute :date, Shale::Type::Date

    # @!attribute [rw] effective_date
    #   Returns the effective date of the transaction
    #   @api public
    #   @example
    #     transaction.effective_date #=> #<Date: 2024-01-16>
    #   @return [Date] the effective date of the transaction
    attribute :effective_date, Shale::Type::Date

    # @!attribute [rw] resolution_date
    #   Returns the resolution date of the transaction
    #   @api public
    #   @example
    #     transaction.resolution_date #=> #<Date: 2024-01-20>
    #   @return [Date] the resolution date of the transaction
    attribute :resolution_date, Shale::Type::Date

    # @!attribute [rw] type_code
    #   Returns the transaction type code
    #   @api public
    #   @example
    #     transaction.type_code #=> "TR"
    #   @return [String] the transaction type code
    attribute :type_code, Shale::Type::String

    # @!attribute [rw] type_desc
    #   Returns the transaction type description
    #   @api public
    #   @example
    #     transaction.type_desc #=> "Trade"
    #   @return [String] the transaction type description
    attribute :type_desc, Shale::Type::String

    # @!attribute [rw] description
    #   Returns the full transaction description
    #   @api public
    #   @example
    #     transaction.description #=> "Player X traded to Team Y for Player Z"
    #   @return [String] the full transaction description
    attribute :description, Shale::Type::String

    json do
      map "id", to: :id
      map "person", to: :player
      map "fromTeam", to: :from_team
      map "toTeam", to: :to_team
      map "date", to: :date
      map "effectiveDate", to: :effective_date
      map "resolutionDate", to: :resolution_date
      map "typeCode", to: :type_code
      map "typeDesc", to: :type_desc
      map "description", to: :description
    end
  end
end
