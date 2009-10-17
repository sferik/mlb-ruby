require 'httparty'
require 'json'
require 'ostruct'

class MLB
  include HTTParty
  base_uri 'http://www.freebase.com/api'

  # Returns an array of objects, one for each Major League Baseball team
  #
  #   MLB.teams.first.name                    # => "Arizona Diamondbacks"
  #   MLB.teams.first.league                  # => "National League"
  #   MLB.teams.first.division                # => "National League West"
  #   MLB.teams.first.manager                 # => "Bob Melvin"
  #   MLB.teams.first.wins                    # => 82
  #   MLB.teams.first.losses                  # => 80
  #   MLB.teams.first.founded                 # => 1998
  #   MLB.teams.first.mascot                  # => nil
  #   MLB.teams.first.ballpark                # => "Chase Field"
  #   MLB.teams.first.logo_url                # => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/en_id/13104064"
  #   MLB.teams.first.players.first.name      # => "Alex Romero"
  #   MLB.teams.first.players.first.number    # => 28
  #   MLB.teams.first.players.first.position  # => "Right fielder"
  def self.teams
    @query ||= team_query
    @response ||= exec_query(@query)
    @results ||= []
    if @response && @results.empty?
      @response['result'].each do |result|
        @results << OpenStruct.new({
          :name     => result['name'],
          :league   => result['league']['name'],
          :division => result['division']['name'],
          :manager  => result['current_manager']['name'],
          :wins     => result['team_stats'].first['wins'].to_i,
          :losses   => result['team_stats'].first['losses'].to_i,
          :founded  => result['/sports/sports_team/founded'].first['value'].to_i,
          :mascot   => (result['/sports/sports_team/team_mascot'].first ? result['/sports/sports_team/team_mascot'].first['name'] : nil),
          :ballpark => result['/sports/sports_team/arena_stadium'].first['name'],
          :logo_url => 'http://img.freebase.com/api/trans/image_thumb' + result['/common/topic/image'].first['id'],
          :players  => result['current_roster'].map {|player|
            OpenStruct.new({
              :name => player['player'],
              :number => player['number'],
              :position => player['position'],
            })
          },
        })
      end
    end
    @results
  end

  private

  # Converts MQL query to JSON and fetches response from Freebase API
  def self.exec_query(query)
    format :json
    begin
      response = get('/service/mqlread?', :query => {:query => query.to_json})
      if response['code'] != '/api/status/ok'
        error("#{response['status']} (Transaction: #{response['transaction_id']})")
      end
    rescue SocketError, Errno::ECONNREFUSED => e
      error("Could not connect. Unclog tubes and try again.")
    end
    response
  end

  # Returns the MQL query for teams, as a Ruby hash
  def self.team_query
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

  def self.error(*messages)
    puts messages.map{|msg| "\033[1;31mError: #{msg}\033[0m"}
  end

end
