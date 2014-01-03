module MLB
  class Player
    attr_reader :name, :number, :positions, :from, :to

    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value) if self.respond_to?(key)
      end
    end

    # Returns an array of Player objects given a team roster
    def self.all_from_roster(players)
      players.select { |player| player['to'].nil? }.map do |player|
        new(
          :name      => player['player'],
          :number    => player['number'].to_i,
          :positions => player['position'],
          :from      => player['from'].to_i,
          :to        => 'Present'
        )
      end
    end
  end
end
