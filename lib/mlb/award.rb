require "equalizer"
require "shale"
require_relative "comparable_by_attribute"
require_relative "league"
require_relative "sport"
require_relative "player"

module MLB
  # Represents an MLB award with recipient and voting information
  class Award < Shale::Mapper
    include Comparable
    include ComparableByAttribute
    include Equalizer.new(:id, :player, :season)

    # Returns the attribute used for sorting
    #
    # @api private
    # @return [Symbol] the attribute used for comparison
    def comparable_attribute = :sort_order

    # @!attribute [rw] id
    #   Returns the unique identifier for the award
    #   @api public
    #   @example
    #     award.id #=> "MLBHOF"
    #   @return [String] the unique identifier for the award
    attribute :id, Shale::Type::String

    # @!attribute [rw] name
    #   Returns the name of the award
    #   @api public
    #   @example
    #     award.name #=> "Hall of Fame"
    #   @return [String] the name of the award
    attribute :name, Shale::Type::String

    # @!attribute [rw] notes
    #   Returns additional notes about the award
    #   @api public
    #   @example
    #     award.notes #=> "First ballot"
    #   @return [String] additional notes about the award
    attribute :notes, Shale::Type::String

    # @!attribute [rw] votes
    #   Returns the number of votes received
    #   @api public
    #   @example
    #     award.votes #=> 393
    #   @return [Integer] the number of votes received
    attribute :votes, Shale::Type::Integer

    # @!attribute [rw] date
    #   Returns the date the award was given
    #   @api public
    #   @example
    #     award.date #=> #<Date: 2024-01-23>
    #   @return [Date] the date the award was given
    attribute :date, Shale::Type::Date

    # @!attribute [rw] season
    #   Returns the season year for the award
    #   @api public
    #   @example
    #     award.season #=> 2024
    #   @return [Integer] the season year for the award
    attribute :season, Shale::Type::Integer

    # @!attribute [rw] sport
    #   Returns the sport associated with the award
    #   @api public
    #   @example
    #     award.sport #=> #<MLB::Sport>
    #   @return [Sport] the sport associated with the award
    attribute :sport, Sport

    # @!attribute [rw] player
    #   Returns the player who received the award
    #   @api public
    #   @example
    #     award.player #=> #<MLB::Player>
    #   @return [Player] the player who received the award
    attribute :player, Player

    # @!attribute [rw] league
    #   Returns the league associated with the award
    #   @api public
    #   @example
    #     award.league #=> #<MLB::League>
    #   @return [League] the league associated with the award
    attribute :league, League

    # @!attribute [rw] sort_order
    #   Returns the sort order for display
    #   @api public
    #   @example
    #     award.sort_order #=> 1
    #   @return [Integer] the sort order for display
    attribute :sort_order, Shale::Type::Integer

    json do
      map "id", to: :id
      map "name", to: :name
      map "sport", to: :sport
      map "league", to: :league
      map "player", to: :player
      map "sortOrder", to: :sort_order
      map "season", to: :season
      map "notes", to: :notes
      map "votes", to: :votes
    end

    # Retrieves recipients of this award for a given season
    #
    # @api public
    # @example
    #   award.recipients(season: 2024) #=> [#<MLB::Award>, ...]
    # @param season [Integer, nil] the season year (defaults to current year)
    # @return [Array<Award>] the list of awards with recipients
    def recipients(season: nil)
      season ||= Utils.current_season
      response = CLIENT.get("awards/#{id}/recipients?#{Utils.build_query(season:)}")
      Awards.from_json(response).awards
    end
  end
end
