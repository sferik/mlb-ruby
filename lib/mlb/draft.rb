require "shale"
require_relative "draft_pick"

module MLB
  # Represents a round in the draft
  class DraftRound < Shale::Mapper
    # @!attribute [rw] round
    #   Returns the round number
    #   @api public
    #   @example
    #     round.round #=> "1"
    #   @return [String] the round
    attribute :round, Shale::Type::String

    # @!attribute [rw] picks
    #   Returns the picks in this round
    #   @api public
    #   @example
    #     round.picks #=> [#<MLB::DraftPick>, ...]
    #   @return [Array<DraftPick>] the picks
    attribute :picks, DraftPick, collection: true

    json do
      map "round", to: :round
      map "picks", to: :picks
    end
  end

  # Represents a draft year
  class DraftYear < Shale::Mapper
    # @!attribute [rw] draft_year
    #   Returns the draft year
    #   @api public
    #   @example
    #     draft.draft_year #=> 2024
    #   @return [Integer] the year
    attribute :draft_year, Shale::Type::Integer

    # @!attribute [rw] rounds
    #   Returns the draft rounds
    #   @api public
    #   @example
    #     draft.rounds #=> [#<MLB::DraftRound>, ...]
    #   @return [Array<DraftRound>] the rounds
    attribute :rounds, DraftRound, collection: true

    json do
      map "draftYear", to: :draft_year
      map "rounds", to: :rounds
    end
  end

  # Provides methods for fetching draft data from the API
  class Draft < Shale::Mapper
    # @!attribute [rw] drafts
    #   Returns the draft data
    #   @api public
    #   @example
    #     draft.drafts #=> #<MLB::DraftYear>
    #   @return [DraftYear] the draft data
    attribute :drafts, DraftYear

    json do
      map "drafts", to: :drafts
    end

    # Retrieves draft picks for a year
    #
    # @api public
    # @example Get draft picks for 2024
    #   MLB::Draft.picks(year: 2024)
    # @example Get draft picks for the current year
    #   MLB::Draft.picks
    # @param year [Integer, nil] the draft year (defaults to current year)
    # @return [Array<DraftPick>] the draft picks
    def self.picks(year: nil)
      year ||= Utils.current_season
      response = CLIENT.get("draft/#{year}")
      result = from_json(response)
      result.drafts&.rounds&.flat_map(&:picks) || []
    end
  end
end
