require 'httparty'
require 'json'

module MLB
  class Team
    include HTTParty
    format :json
    base_uri 'http://www.freebase.com/api'
    attr_reader :name, :league, :division, :manager, :wins, :losses, :founded, :mascot, :ballpark, :logo_url, :players
    private_class_method :new

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
      @query ||= query
      @response ||= execute(@query)
      @results ||= []
      if @response && @results.empty?
        @response['result'].each do |result|
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

          @results << new(
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
      end
      @results
    end

    private

    def initialize(attributes={})
      super unless attributes.is_a?(Hash)
      @name     = attributes[:name]
      @league   = attributes[:league]
      @division = attributes[:division]
      @manager  = attributes[:manager]
      @wins     = attributes[:wins]
      @losses   = attributes[:losses]
      @founded  = attributes[:founded]
      @mascot   = attributes[:mascot]
      @ballpark = attributes[:ballpark]
      @logo_url = attributes[:logo_url]
      @players  = attributes[:players]
    end

    # Converts MQL query to JSON and fetches response from Freebase API
    def self.execute(query)
      begin
        response = get('/service/mqlread?', :query => {:query => query.to_json})
        if response['code'] != '/api/status/ok'
          raise Exception, "#{response['status']} (Transaction: #{response['transaction_id']})"
        end
      rescue SocketError, Errno::ECONNREFUSED
        raise Exception, "Could not connect. Unclog tubes and try again."
      end
      response
    end

    # Returns the MQL query for teams, as a Ruby hash
    def self.query
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

  end
end
