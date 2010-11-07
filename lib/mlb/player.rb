module MLB
  class Player
    private_class_method :new
    attr_reader :name, :number, :position

    private

    def initialize(attributes={})
      attributes.each_pair do |key, value|
        instance_eval("@#{key}=value") if self.respond_to?(key)
      end
    end

    # Returns an array of Player objects given a team roster
    def self.all_from_roster(players)
      players.map do |player|
        new(
          :name     => player['player'],
          :number   => player['number'],
          :position => player['position']
        )
      end
    end

  end
end
