require 'helper'

describe MLB::Team, '.all' do
  context 'with connection' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => MLB::Team.mql_query}).to_return(:body => fixture('teams.json'))
    end

    after do
      MLB::Team.reset
    end

    it 'requests the correct resource' do
      MLB::Team.all
      expect(a_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => MLB::Team.mql_query})).to have_been_made
    end

    it 'returns the correct team results' do
      teams = MLB::Team.all
      expect(teams.first.name).to eq 'Arizona Diamondbacks'
    end

    it 'returns the correct player results' do
      teams = MLB::Team.all
      expect(teams.first.players.first.name).to eq 'A.J. Pollock'
    end
  end

  context 'with timeout' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => MLB::Team.mql_query}).to_timeout
    end

    after do
      MLB::Team.reset
    end

    it 'returns the correct results' do
      teams = MLB::Team.all
      expect(teams.first.name).to eq 'Arizona Diamondbacks'
    end
  end

  context 'without connection' do
    before do
      stub_request(:get, 'https://www.googleapis.com/freebase/v1/mqlread').with(:query => {:query => MLB::Team.mql_query}).to_raise(SocketError)
    end

    after do
      MLB::Team.reset
    end

    it 'returns the correct results' do
      teams = MLB::Team.all
      expect(teams.first.name).to eq 'Arizona Diamondbacks'
    end
  end
end
