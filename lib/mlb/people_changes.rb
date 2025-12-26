require "shale"
require "uri"
require_relative "player"

module MLB
  # Provides methods for fetching people changes from the API
  class PeopleChanges < Shale::Mapper
    # @!attribute [rw] people
    #   Returns the changed people
    #   @api public
    #   @example
    #     people_changes.people #=> [#<MLB::Player>, ...]
    #   @return [Array<Player>] the changed people
    attribute :people, Player, collection: true

    json do
      map "people", to: :people
    end

    # Retrieves people changes since a date
    #
    # @api public
    # @example Get people changes since a date
    #   MLB::PeopleChanges.since(date: Date.new(2024, 6, 1))
    # @param date [Date] the date to check changes from
    # @return [Array<Player>] the changed people
    def self.since(date:)
      params = {updatedSince: date.to_s}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("people/changes?#{query_string}")
      from_json(response).people
    end
  end
end
