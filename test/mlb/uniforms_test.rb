require_relative "../test_helper"

module MLB
  class GameUniformsTest < Minitest::Test
    cover GameUniforms

    def test_self_find_with_game_id
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571")
        .to_return(body: game_uniforms_json, headers: json_headers)
      uniforms = GameUniforms.find(game: 745_571)

      assert_requested :get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571"
      assert_equal 147, uniforms.away.team_id
      assert_equal 119, uniforms.home.team_id
    end

    def test_self_find_with_scheduled_game
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571")
        .to_return(body: game_uniforms_json, headers: json_headers)
      game = ScheduledGame.new(game_pk: 745_571)
      uniforms = GameUniforms.find(game:)

      assert_equal 147, uniforms.away.team_id
    end

    def test_uniform_colors
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571")
        .to_return(body: game_uniforms_json, headers: json_headers)
      uniforms = GameUniforms.find(game: 745_571)

      assert_equal "Blue", uniforms.away.jersey_color.name
      assert_equal "#003087", uniforms.away.jersey_color.hex
    end

    def test_uniform_cap_color
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571")
        .to_return(body: game_uniforms_json, headers: json_headers)
      uniforms = GameUniforms.find(game: 745_571)

      assert_equal "Navy", uniforms.away.cap_color.name
    end

    def test_uniform_assets
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/game?gamePk=745571")
        .to_return(body: game_uniforms_json, headers: json_headers)
      uniforms = GameUniforms.find(game: 745_571)

      assert_equal "https://example.com/cap.png", uniforms.away.assets.cap
      assert_equal "https://example.com/jersey.png", uniforms.away.assets.jersey
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def game_uniforms_json
      '{"copyright":"Copyright","away":{"teamId":147,"uniformType":"A",' \
        '"jerseyColor":{"name":"Blue","hex":"#003087"},' \
        '"capColor":{"name":"Navy","hex":"#003087"},' \
        '"assets":{"cap":"https://example.com/cap.png",' \
        '"jersey":"https://example.com/jersey.png"}},' \
        '"home":{"teamId":119,"uniformType":"H",' \
        '"jerseyColor":{"name":"White","hex":"#FFFFFF"},' \
        '"capColor":{"name":"Red","hex":"#C41E3A"},' \
        '"assets":{"cap":"https://example.com/cap2.png",' \
        '"jersey":"https://example.com/jersey2.png"}}}'
    end
  end

  class TeamUniformsTest < Minitest::Test
    cover TeamUniforms

    def test_self_find_with_team_id
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/team?season=#{year}&teamId=147")
        .to_return(body: team_uniforms_json, headers: json_headers)
      uniforms = TeamUniforms.find(team: 147)

      assert_equal 2, uniforms.size
      assert_equal 147, uniforms.first.team_id
    end

    def test_self_find_with_team_object
      year = Time.now.year
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/team?season=#{year}&teamId=147")
        .to_return(body: team_uniforms_json, headers: json_headers)
      team = Team.new(id: 147)
      uniforms = TeamUniforms.find(team:)

      assert_equal 2, uniforms.size
    end

    def test_self_find_with_season
      stub_request(:get, "https://statsapi.mlb.com/api/v1/uniforms/team?season=2023&teamId=147")
        .to_return(body: team_uniforms_json, headers: json_headers)
      uniforms = TeamUniforms.find(team: 147, season: 2023)

      assert_equal 2, uniforms.size
    end

    private

    def json_headers
      {"Content-Type" => "application/json;charset=UTF-8"}
    end

    def team_uniforms_json
      home_uniform = '{"teamId":147,"uniformType":"H","jerseyColor":{"name":"White","hex":"#FFFFFF"},' \
                     '"capColor":{"name":"Blue","hex":"#003087"},"assets":{"cap":"https://example.com/cap.png",' \
                     '"jersey":"https://example.com/jersey.png"}}'
      away_uniform = '{"teamId":147,"uniformType":"A","jerseyColor":{"name":"Gray","hex":"#808080"},' \
                     '"capColor":{"name":"Blue","hex":"#003087"},"assets":{"cap":"https://example.com/cap2.png",' \
                     '"jersey":"https://example.com/jersey2.png"}}'
      %({"copyright":"Copyright","uniforms":[#{home_uniform},#{away_uniform}]})
    end
  end

  class UniformInfoTest < Minitest::Test
    cover UniformInfo

    def test_equality
      u1 = UniformInfo.new(team_id: 147, uniform_type: "H")
      u2 = UniformInfo.new(team_id: 147, uniform_type: "H")

      assert_equal u1, u2
    end

    def test_inequality
      u1 = UniformInfo.new(team_id: 147, uniform_type: "H")
      u2 = UniformInfo.new(team_id: 147, uniform_type: "A")

      refute_equal u1, u2
    end
  end

  class UniformColorTest < Minitest::Test
    cover UniformColor
  end

  class UniformAssetTest < Minitest::Test
    cover UniformAsset
  end
end
