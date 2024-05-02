require "date"
require "uri"

module MLB
  Transaction = Struct.new(:conditional_sw, :effective_date, :final_asset,
    :final_asset_type, :from_team, :from_team_id, :name_display_first_last,
    :name_display_last_first, :name_sort, :note, :orig_asset, :orig_asset_type,
    :player, :player_id, :resolution_cd, :resolution_date, :team, :team_id,
    :trans_date, :trans_date_cd, :transaction_id, :type, :type_cd, keyword_init: true) do
    def self.all(start_date: Date.today, end_date: Date.today)
      sport_code = "'mlb'"
      start_date = Date.parse(start_date.to_s).strftime("%Y%m%d")
      end_date = Date.parse(end_date.to_s).strftime("%Y%m%d")
      params = {sport_code:, start_date:, end_date:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("named.transaction_all.bam?#{query_string}")
      transactions = response.fetch(:transaction_all, {}).fetch(:queryResults, {}).fetch(:row, [])
      transactions.collect { |transaction| Transaction.new(**transaction) }
    end

    def team
      require_relative "team"
      teams = effective_date.to_s.empty? ? Team.all : Team.all(season: effective_date.to_s[0...4].to_i)
      teams.find { |t| t[:team_id] == team_id.to_s }
    end

    def player
      params = {team_id:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("named.roster_40.bam?#{query_string}")
      players = response[:roster_40][:queryResults][:row]
      player = players.find { |p| p[:player_id] == player_id.to_s }
      require_relative "player"
      Player.new(**player)
    end
  end
end
