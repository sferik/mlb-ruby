require "uri"

module MLB
  Team = Struct.new(:active_sw, :address, :address_city,
    :address_country, :address_intl, :address_line1, :address_line2,
    :address_line3, :address_province, :address_state, :address_zip, :all_star_sw,
    :base_url, :bis_team_code, :city, :division, :division_abbrev, :division_full,
    :division_id, :file_code, :first_year_of_play, :franchise_code, :home_opener,
    :home_opener_time, :last_year_of_play, :league, :league_abbrev, :league_full,
    :league_id, :mlb_org, :mlb_org_abbrev, :mlb_org_brief, :mlb_org_id,
    :mlb_org_short, :name, :name_abbrev, :name_display_brief, :name_display_full,
    :name_display_long, :name_display_short, :name_short, :phone_number, :season,
    :sport_code, :sport_code_display, :sport_code_name, :sport_id, :spring_league,
    :spring_league_abbrev, :spring_league_full, :spring_league_id, :state,
    :store_url, :team_code, :team_id, :time_zone, :time_zone_alt,
    :time_zone_generic, :time_zone_num, :time_zone_text, :venue_id, :venue_name,
    :venue_short, :website_url, keyword_init: true) do
    def self.all(season: Time.now.year, sort_order: "name_asc", all_star: false)
      sport_code = "'mlb'"
      season = "'#{season}'"
      all_star_sw = all_star ? "'Y'" : "'N'"
      params = {sport_code:, season:, sort_order:, all_star_sw:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("named.team_all_season.bam?#{query_string}")
      teams = response[:team_all_season][:queryResults][:row]
      teams.collect { |team| Team.new(**team) }
    end

    def roster
      require_relative "player"
      params = {team_id:}
      query_string = URI.encode_www_form(params)
      response = CLIENT.get("named.roster_40.bam?#{query_string}")
      players = response[:roster_40][:queryResults][:row]
      players.collect { |player| Player.new(**player) }
    end
  end
end
