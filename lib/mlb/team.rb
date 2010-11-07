module MLB
  class Team
    private_class_method :new
    attr_reader :name, :league, :division, :manager, :wins, :losses, :founded, :mascot, :ballpark, :logo_url, :players

    # Returns an array of Team objects
    #
    # @example
    #   MLB::Team.all.first.name                    # => "Arizona Diamondbacks"
    #   MLB::Team.all.first.league                  # => "National League"
    #   MLB::Team.all.first.division                # => "National League West"
    #   MLB::Team.all.first.manager                 # => "Bob Melvin"
    #   MLB::Team.all.first.wins                    # => 82
    #   MLB::Team.all.first.losses                  # => 80
    #   MLB::Team.all.first.founded                 # => 1998
    #   MLB::Team.all.first.mascot                  # => nil
    #   MLB::Team.all.first.ballpark                # => "Chase Field"
    #   MLB::Team.all.first.logo_url                # => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/en_id/13104064"
    #   MLB::Team.all.first.players.first.name      # => "Alex Romero"
    #   MLB::Team.all.first.players.first.number    # => 28
    #   MLB::Team.all.first.players.first.position  # => "Right fielder"
    def self.all
      # Attempt to fetch the result from the Freebase API unless there is a
      # connection error, in which case read from a fixture file
      @all ||= begin
        results_to_team(results_from_freebase)
      rescue SocketError, Errno::ECONNREFUSED, Timeout::Error
        results_to_team(results_from_cache)
      end
    end

    def self.reset
      @all = nil
    end

    private

    def initialize(attributes={})
      attributes.each_pair do |key, value|
        instance_eval("@#{key}=value") if self.respond_to?(key)
      end
    end

    def self.results_from_freebase
      Request.get('/api/service/mqlread', :query => mql_query)
    end

    def self.results_from_cache
      Yajl::Parser.parse(file_from_cache("teams.json"))
    end

    def self.file_from_cache(file_name)
      File.new(File.expand_path("../../../cache", __FILE__) + "/" + file_name)
    end

    def self.results_to_team(results)
      teams = []
      results['result'].each do |result|
        league      = result['league']
        division    = result['division']
        manager     = result['current_manager']
        stats       = result['team_stats'].first
        founded     = result['/sports/sports_team/founded'].first
        mascot      = result['/sports/sports_team/team_mascot'].first
        ballpark    = result['/sports/sports_team/arena_stadium'].first
        logo_prefix = 'http://img.freebase.com/api/trans/image_thumb'
        logo_suffix = result['/common/topic/image'].first
        players     = result['current_roster']

        teams << new(
          :name     => result['name'],
          :league   => (league      ? league['name']                  : nil),
          :division => (division    ? division['name']                : nil),
          :manager  => (manager     ? manager['name']                 : nil),
          :wins     => (stats       ? stats['wins'].to_i              : nil),
          :losses   => (stats       ? stats['losses'].to_i            : nil),
          :founded  => (founded     ? founded['value'].to_i           : nil),
          :mascot   => (mascot      ? mascot['name']                  : nil),
          :ballpark => (ballpark    ? ballpark['name']                : nil),
          :logo_url => (logo_suffix ? logo_prefix + logo_suffix['id'] : nil),
          :players  => (players     ? Player.all_from_roster(players) : [])
        )
      end
      teams
    end

    # Returns the MQL query for teams, as a Ruby hash
    def self.mql_query
      query = <<-eos
        [{
          "name":          null,
          "league": {
            "name": null
          },
          "division": {
            "name": null
          },
          "current_manager": {
            "name": null
          },
          "team_stats": [{
            "wins":   null,
            "losses": null,
            "season": null,
            "limit":  1,
            "sort":   "-season"
          }],
          "current_roster": [{
            "player":   null,
            "position": null,
            "number":   null,
            "sort":     "player"
          }],
          "/sports/sports_team/founded": [{
            "value": null
          }],
          "/sports/sports_team/team_mascot": [{}],
          "/sports/sports_team/arena_stadium": [{
            "name": null
          }],
          "/common/topic/image": [{
            "id":        null,
            "timestamp": null,
            "sort":      "-timestamp",
            "limit":     1
          }],
          "sort":          "name",
          "type":          "/baseball/baseball_team"
        }]
        eos
      '{"query":' + query.gsub!("\n", '').gsub!(' ', '') + '}'
    end

  end
end
