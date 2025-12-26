require "equalizer"
require "shale"
require_relative "player"
require_relative "team"

module MLB
  # Represents a player transaction (trade, signing, etc.)
  class Transaction < Shale::Mapper
    include Equalizer.new(:id)

    TYPE_TRADE = "TR".freeze
    TYPE_FREE_AGENT = "FA".freeze
    TYPE_ASSIGNMENT = "ASG".freeze
    TYPE_SIGNING = "SGN".freeze
    TYPE_RELEASE = "REL".freeze
    TYPE_WAIVER = "WV".freeze

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

    # Returns whether this is a trade transaction
    #
    # @api public
    # @example
    #   transaction.trade? #=> true
    # @return [Boolean] whether this is a trade
    def trade? = type_code.eql?(TYPE_TRADE)

    # Returns whether this is a free agent transaction
    #
    # @api public
    # @example
    #   transaction.free_agent? #=> false
    # @return [Boolean] whether this is a free agent signing
    def free_agent? = type_code.eql?(TYPE_FREE_AGENT)

    # Returns whether this is an assignment transaction
    #
    # @api public
    # @example
    #   transaction.assignment? #=> false
    # @return [Boolean] whether this is an assignment
    def assignment? = type_code.eql?(TYPE_ASSIGNMENT)

    # Returns whether this is a signing transaction
    #
    # @api public
    # @example
    #   transaction.signing? #=> false
    # @return [Boolean] whether this is a signing
    def signing? = type_code.eql?(TYPE_SIGNING)

    # Returns whether this is a release transaction
    #
    # @api public
    # @example
    #   transaction.release? #=> false
    # @return [Boolean] whether this is a release
    def release? = type_code.eql?(TYPE_RELEASE)

    # Returns whether this is a waiver transaction
    #
    # @api public
    # @example
    #   transaction.waiver? #=> false
    # @return [Boolean] whether this is a waiver
    def waiver? = type_code.eql?(TYPE_WAIVER)

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
