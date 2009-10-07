require 'httparty'
require 'json'
require 'ostruct'

class MLB
  include HTTParty
  base_uri 'http://www.freebase.com/api'

  def self.teams
    format :json
    @query ||= team_query
    @response ||= exec_mql(@query)
    @results ||= []
    if @results.empty?
      @response['result'].each do |result|
        @results << OpenStruct.new({
          :name     => result['name'],
          :league   => result['league']['name'],
          :division => result['division']['name'],
          :manager  => result['current_manager']['name'],
          :players  => result['current_roster'].map{|player| OpenStruct.new({:name => player['player'], :number => player['number'], :position => player['position'],})},
          :wins     => result['team_stats'].first['wins'].to_i,
          :losses   => result['team_stats'].first['losses'].to_i,
          :founded  => result['/sports/sports_team/founded'].first['value'].to_i,
          :mascot   => (result['/sports/sports_team/team_mascot'].first ? result['/sports/sports_team/team_mascot'].first['name'] : nil),
          :ballpark => result['/sports/sports_team/arena_stadium'].first['name'],
          :logo_url => 'http://img.freebase.com/api/trans/image_thumb' + result['/common/topic/image'].first['id'],
        })
      end
    end
    @results
  end

  private

  def self.exec_mql(query)
    response ||= get('/service/mqlread?', :query => {:query => query.to_json})
    unless response['code'] == '/api/status/ok'
      errors = Array(response['messages']).map{|m| m.inspect}.join(', ')
      raise "#{response['status']}: #{errors} (#{response['transaction_id']})"
    end
    response
  end

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

end
