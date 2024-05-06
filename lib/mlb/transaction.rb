require "shale"
require_relative "player"
require_relative "team"

module MLB
  class Transaction < Shale::Mapper
    attribute :id, Shale::Type::Integer
    attribute :player, Player
    attribute :from_team, Team, default: nil
    attribute :to_team, Team
    attribute :date, Shale::Type::Date
    attribute :effective_date, Shale::Type::Date
    attribute :resolution_date, Shale::Type::Date
    attribute :type_code, Shale::Type::String
    attribute :type_desc, Shale::Type::String
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
