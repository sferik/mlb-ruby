module MLB
  Player = Struct.new(:bats, :birth_date, :college, :end_date, :height_feet,
    :height_inches, :jersey_number, :name_display_first_last,
    :name_display_last_first, :name_first, :name_full, :name_last, :name_use,
    :player_id, :position_txt, :primary_position, :pro_debut_date, :start_date,
    :starter_sw, :status_code, :team_abbrev, :team_code, :team_id, :team_name,
    :throws, :weight, keyword_init: true) do
    def team
      require_relative "team"
      sport_code = "'mlb'"
      season = Time.now.year
      all_star_sw = "'N'"
      params = {sport_code:, season:, all_star_sw:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("named.team_all_season.bam?#{query_string}")
      teams = response[:team_all_season][:queryResults][:row]
      team = teams.find { |t| t[:team_id] == team_id.to_s }
      Team.new(**team)
    end
  end
end
