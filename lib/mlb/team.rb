require 'httparty'
require 'json'

module MLB
  class Team
    include HTTParty
    format :json
    base_uri 'http://www.freebase.com/api'
    attr_accessor :name, :league, :division, :manager, :wins, :losses, :founded, :mascot, :ballpark, :logo_url, :players

    # Returns an array of Team objects
    #
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
      @results ||= run
    end

    def initialize(attributes={})
      attributes.each_pair do |key, value|
        self.send("#{key}=", value) if self.respond_to?("#{key}=")
      end
    end

    private

    # Attempt to fetch the result from the Freebase API
    # unless there is a connection error, in which case
    # query a static SQLite3 database.
    def self.run
      begin
        run_team_mql
      rescue SocketError, Errno::ECONNREFUSED
        run_team_sql
      end
    end

    def self.run_team_mql
      query = team_mql_query
      results = get('/service/mqlread?', :query => {:query => query.to_json})
      raise(Exception, "#{results['status']} (Transaction: #{results['transaction_id']})") unless results['code'] == '/api/status/ok'

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

    def self.setup_db
      require 'sqlite3'
      @db ||= SQLite3::Database.new(File.join(File.dirname(__FILE__), "..", "..", "db", "mlb.sqlite3"), :type_translation => true, :results_as_hash => true)
    end

    def self.run_team_sql
      db = setup_db
      query = team_sql_query
      results = db.execute(query)

      teams = []
      results.each do |result|
        teams << new(
          :name     => result['name'],
          :league   => result['league'],
          :division => result['division'],
          :manager  => result['manager'],
          :wins     => result['wins'],
          :losses   => result['losses'],
          :founded  => result['founded'],
          :mascot   => result['mascot'],
          :ballpark => result['ballpark'],
          :logo_url => result['logo_url'],
          :players  => run_player_sql(result['name'])
        )
      end
      teams
    end

    def self.run_player_sql(team_name)
      db = setup_db
      query = player_sql_query(team_name)
      results = db.execute(query)

      players = []
      results.each do |result|
        players << Player.new(
          :name     => result['name'],
          :position => result['position'],
          :number   => result['number']
        )
      end
      players
    end

    # Returns the MQL query for teams, as a Ruby hash
    def self.team_mql_query
      {
        :query => [
          {
            'name' => nil,
            'league' => {
              'name' => nil,
            },
            'division' => {
              'name' => nil,
            },
            'current_manager' => {
              'name' => nil,
            },
            'team_stats' => [{
              'wins' => nil,
              'losses' => nil,
              'season' => nil,
              'limit' => 1,
              'sort' => '-season',
            }],
            'current_roster' => [{
              'player' => nil,
              'position' => nil,
              'number' => nil,
              'sort' => 'player',
            }],
            '/sports/sports_team/founded' => [{
              'value' => nil,
            }],
            '/sports/sports_team/team_mascot' => [{
            }],
            '/sports/sports_team/arena_stadium' => [{
              'name' => nil,
            }],
            '/common/topic/image' => [{
              'id' => nil,
              'timestamp' => nil,
              'sort' => '-timestamp',
              'limit' => 1,
            }],
            'sort' => 'name',
            'type' => '/baseball/baseball_team',
          }
        ]
      }
    end

    def self.team_sql_query
      <<-eos
        SELECT teams.name     AS name
             , leagues.name   AS league
             , divisions.name AS division
             , teams.manager  AS manager
             , teams.wins     AS wins
             , teams.losses   AS losses
             , teams.founded  AS founded
             , teams.mascot   AS mascot
             , teams.ballpark AS ballpark
             , teams.logo_url AS logo_url
          FROM teams
             , divisions
             , leagues
         WHERE teams.division_id = divisions.id
           AND divisions.league_id = leagues.id
      ORDER BY teams.name
      eos
    end

    def self.player_sql_query(team_name)
      <<-eos
        SELECT players.name     AS name
             , players.position AS position
             , players.number   AS number
          FROM players
             , teams
         WHERE players.team_id = teams.id
           AND teams.name = "#{team_name}"
      ORDER BY players.name
      eos
    end

  end
end
