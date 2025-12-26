require "shale"
require_relative "division"
require_relative "league"
require_relative "sport"
require_relative "team_record"

module MLB
  # Represents a standings record for a division
  class StandingsRecord < Shale::Mapper
    STANDINGS_REGULAR_SEASON = "regularSeason".freeze
    STANDINGS_WILD_CARD = "wildCard".freeze
    STANDINGS_DIVISION_LEADERS = "divisionLeaders".freeze
    STANDINGS_WILD_CARD_WITH_LEADERS = "wildCardWithLeaders".freeze
    STANDINGS_FIRST_HALF = "firstHalf".freeze
    STANDINGS_SECOND_HALF = "secondHalf".freeze
    STANDINGS_SPRING_TRAINING = "springTraining".freeze
    STANDINGS_POSTSEASON = "postseason".freeze

    # @!attribute [rw] standings_type
    #   Returns the standings type
    #   @api public
    #   @example
    #     standings_record.standings_type #=> "regularSeason"
    #   @return [String] the standings type
    attribute :standings_type, Shale::Type::String

    # @!attribute [rw] league
    #   Returns the league
    #   @api public
    #   @example
    #     standings_record.league #=> #<MLB::League>
    #   @return [League] the league
    attribute :league, League

    # @!attribute [rw] division
    #   Returns the division
    #   @api public
    #   @example
    #     standings_record.division #=> #<MLB::Division>
    #   @return [Division] the division
    attribute :division, Division

    # @!attribute [rw] sport
    #   Returns the sport
    #   @api public
    #   @example
    #     standings_record.sport #=> #<MLB::Sport>
    #   @return [Sport] the sport
    attribute :sport, Sport

    # @!attribute [rw] last_updated
    #   Returns when the standings were last updated
    #   @api public
    #   @example
    #     standings_record.last_updated #=> "2024-09-23T02:30:10.088Z"
    #   @return [String] when the standings were last updated
    attribute :last_updated, Shale::Type::String

    # @!attribute [rw] team_records
    #   Returns the team records
    #   @api public
    #   @example
    #     standings_record.team_records #=> [#<MLB::TeamRecord>, ...]
    #   @return [Array<TeamRecord>] the team records
    attribute :team_records, TeamRecord, collection: true

    # Returns whether this is regular season standings
    #
    # @api public
    # @example
    #   standings_record.regular_season? #=> true
    # @return [Boolean] whether this is regular season standings
    def regular_season? = standings_type.eql?(STANDINGS_REGULAR_SEASON)

    # Returns whether this is wild card standings
    #
    # @api public
    # @example
    #   standings_record.wild_card? #=> false
    # @return [Boolean] whether this is wild card standings
    def wild_card? = standings_type.eql?(STANDINGS_WILD_CARD)

    # Returns whether this is spring training standings
    #
    # @api public
    # @example
    #   standings_record.spring_training? #=> false
    # @return [Boolean] whether this is spring training standings
    def spring_training? = standings_type.eql?(STANDINGS_SPRING_TRAINING)

    # Returns whether this is postseason standings
    #
    # @api public
    # @example
    #   standings_record.postseason? #=> false
    # @return [Boolean] whether this is postseason standings
    def postseason? = standings_type.eql?(STANDINGS_POSTSEASON)

    json do
      map "standingsType", to: :standings_type
      map "league", to: :league
      map "division", to: :division
      map "sport", to: :sport
      map "lastUpdated", to: :last_updated
      map "teamRecords", to: :team_records
    end
  end
end
