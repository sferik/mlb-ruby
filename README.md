[![Tests](https://github.com/sferik/mlb-ruby/actions/workflows/test.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/test.yml)
[![Mutant](https://github.com/sferik/mlb-ruby/actions/workflows/mutant.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/mutant.yml)
[![Linter](https://github.com/sferik/mlb-ruby/actions/workflows/lint.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/lint.yml)
[![Gem Version](https://badge.fury.io/rb/mlb.svg)](https://rubygems.org/gems/mlb)

# A [Ruby](https://www.ruby-lang.org) interface to the [MLB Stats API](https://statsapi.mlb.com)

## Follow

For updates and announcements, follow [@sferik](https://x.com/sferik).

## Installation

Install the gem and add to the application's Gemfile:

    bundle add mlb

Or, if Bundler is not being used to manage dependencies:

    gem install mlb

## Usage

```ruby
require "mlb"
```

### Teams

```ruby
# Get all MLB teams for a season
teams = MLB::Teams.all(season: 2025)
teams.size                   # => 30

mets = teams.find { |t| t.id == MLB::Team::NYM }
mets.name                    # => "New York Mets"
mets.short_name              # => "NY Mets"
mets.league.name             # => "National League"
mets.division.name           # => "National League East"
mets.first_year_of_play      # => 1962
mets.venue.name              # => "Citi Field"
```

### Roster

```ruby
# Get a team's roster
roster = MLB::Roster.find(team: MLB::Team::NYM, season: 2025)
roster.size                        # => 39

# Find a specific player on the roster
entry = roster.find { |e| e.player.full_name == "Francisco Lindor" }
entry.player.full_name             # => "Francisco Lindor"
entry.jersey_number                # => 12
entry.position.name                # => "Shortstop"
entry.status.description           # => "Active"
```

### Players

```ruby
# Find a player by ID
senga = MLB::Players.find(807882)
senga.full_name               # => "Kodai Senga"
senga.primary_number          # => 34
senga.primary_position.name   # => "Pitcher"
senga.pitch_hand.description  # => "Right"
senga.bat_side.description    # => "Right"
senga.current_age             # => 32
senga.birth_date.to_s         # => "1993-01-30"
senga.birth_city              # => "Nagaoka"
senga.birth_state_province    # => "Niigata"
senga.birth_country           # => "Japan"
senga.mlb_debut_date.to_s     # => "2023-04-01"
senga.height                  # => "6' 1\""
senga.weight                  # => 200
senga.active?                 # => true
```

### Schedule

```ruby
# Get games for a specific date
games = MLB::Schedule.games(date: Date.new(2025, 6, 14))
games.size                       # => 15

# Get games for a specific team (Mets home opener)
mets_games = MLB::Schedule.games(date: Date.new(2025, 4, 4), team: MLB::Team::NYM)
game = mets_games.first
game.game_pk                     # => 778465
game.official_date.to_s          # => "2025-04-04"
game.status.final?               # => true
game.venue.name                  # => "Citi Field"
game.day?                        # => true
game.description                 # => "Mets home opener"
game.teams.away.team.name        # => "Toronto Blue Jays"
game.teams.home.team.name        # => "New York Mets"
game.teams.away.score            # => 0
game.teams.home.score            # => 5
game.teams.home.winner?          # => true
```

### Standings

```ruby
# Get all division standings
standings = MLB::Standings.all(season: 2025)
standings.size                         # => 6

# Access a specific division
nl_east = standings.find { |s| s.division.name == "National League East" }
nl_east.division.name                  # => "National League East"
nl_east.team_records.size              # => 5

# Get team standings info (Mets finished 2nd in NL East in 2025)
mets = nl_east.team_records.find { |r| r.team.name == "New York Mets" }
mets.team.name                         # => "New York Mets"
mets.wins                              # => 83
mets.losses                            # => 79
mets.winning_percentage                # => ".512"
mets.games_back                        # => "13.0"
mets.runs_scored                       # => 766
mets.runs_allowed                      # => 715
mets.run_differential                  # => 51
mets.division_rank                     # => "2"
mets.streak.streak_code                # => "L1"
```

### Team Leaders

```ruby
# Get home run leaders for a specific team
hr_leaders = MLB::TeamLeaders.find(team: MLB::Team::NYM, category: "homeRuns", season: 2025)
hr_leaders.size                        # => 10

hr_leader = hr_leaders.first
hr_leader.rank                         # => 1
hr_leader.value                        # => "43"
hr_leader.person.full_name             # => "Juan Soto"
```

### League Leaders

```ruby
# Get home run leaders
hr_leaders = MLB::Leaders.find(category: "homeRuns", season: 2025, limit: 5)
hr_leader = hr_leaders.first
hr_leader.rank                         # => 1
hr_leader.value                        # => "60"
hr_leader.person.full_name             # => "Cal Raleigh"
hr_leader.team.name                    # => "Seattle Mariners"

# Get batting average leaders
avg_leaders = MLB::Leaders.find(category: "battingAverage", season: 2025, limit: 3)
avg_leaders.first.person.full_name     # => "Aaron Judge"
avg_leaders.first.value                # => ".331"

# Get wins leaders for pitchers
wins_leaders = MLB::Leaders.find(category: "wins", season: 2025, limit: 3)
wins_leaders.first.person.full_name    # => "Max Fried"
wins_leaders.first.value               # => "19"
```

### Awards

```ruby
# Find an award and get its recipients
mvp = MLB::Awards.find("NLMVP")
recipients = mvp.recipients(season: 2025)
winner = recipients.first
winner.player.full_name                # => "Shohei Ohtani"
```

### Draft

```ruby
# Get draft picks for a year
picks = MLB::Draft.picks(year: 2025)
picks.size                             # => 615

# First overall pick
first_pick = picks.first
first_pick.pick_number                 # => 1
first_pick.pick_round                  # => "1"
first_pick.person.full_name            # => "Eli Willits"
first_pick.team.name                   # => "Washington Nationals"
first_pick.school.name                 # => "Fort Cobb-Broxton HS"
first_pick.school.school_class         # => "HS SR"
first_pick.pick_value                  # => "11075900"
first_pick.signing_bonus               # => "8200000"
```

### Transactions

```ruby
# Get transactions for a date range
transactions = MLB::Transactions.between(
  start_date: Date.new(2025, 12, 22),
  end_date: Date.new(2025, 12, 22)
)

# Find a specific transaction
trade = transactions.find { |t| t.trade? && t.player&.full_name == "Jeff McNeil" }
trade.trade?                           # => true
trade.player.full_name                 # => "Jeff McNeil"
trade.from_team.name                   # => "New York Mets"
trade.to_team.name                     # => "Athletics"
trade.description                      # => "New York Mets traded 2B Jeff McNeil and cash to Athletics for RHP Yordan Rodriguez."
```

### Boxscore

```ruby
# Get boxscore for Mets home opener (5-0 shutout win)
boxscore = MLB::Boxscore.find(game: 778465)

# Team batting stats
home_batting = boxscore.teams.home.team_stats.batting
home_batting.runs                      # => 5
home_batting.hits                      # => 4
home_batting.home_runs                 # => 1
home_batting.rbi                       # => 5

# Team pitching stats
home_pitching = boxscore.teams.home.team_stats.pitching
home_pitching.innings_pitched          # => "9.0"
home_pitching.hits                     # => 4
home_pitching.strike_outs              # => 10
home_pitching.earned_runs              # => 0
```

### Linescore

```ruby
# Get linescore for 2025 World Series Game 7 (11 innings)
linescore = MLB::Linescore.find(game: 813024)
linescore.scheduled_innings            # => 9
linescore.innings.count                # => 11

# Team totals (runs, hits, errors)
linescore.teams.home.runs              # => 4
linescore.teams.home.hits              # => 14
linescore.teams.away.runs              # => 5
linescore.teams.away.hits              # => 11

# Inning-by-inning breakdown
eleventh = linescore.innings[10]
eleventh.ordinal_num                   # => "11th"
eleventh.away.runs                     # => 1
eleventh.away.hits                     # => 1
```

### Play-by-Play

```ruby
# Get play-by-play for Mets home opener
pbp = MLB::PlayByPlay.find(game: 778465)
pbp.all_plays.size                     # => 65
pbp.scoring_plays.size                 # => 4

# Find scoring plays
scoring = pbp.all_plays.select { |p| p.about.scoring_play? }
hr = scoring.first
hr.about.inning                        # => 1
hr.about.scoring_play?                 # => true
hr.result.event                        # => "Home Run"
hr.result.description                  # => "Pete Alonso homers (3) on a fly ball to right field.    Francisco Lindor scores."
hr.result.rbi                          # => 2
hr.matchup.batter.full_name            # => "Pete Alonso"
hr.matchup.pitcher.full_name           # => "Kevin Gausman"
```

### Win Probability

```ruby
# Get win probability data for 2025 World Series Game 7
# Dodgers vs Blue Jays at Rogers Centre (Dodgers won 5-4 in 11 innings)
wp = MLB::WinProbability.find(game: 813024)
wp.size                                # => 99

# Probability at game start (away team Dodgers slight favorites)
wp.first.at_bat_index                  # => 0
wp.first.home_team_win_probability     # => 0.464
wp.first.away_team_win_probability     # => 0.536

# After Bo Bichette's 3-run HR in the 3rd, Blue Jays led 3-0
wp[22].home_team_win_probability       # => 0.828
wp[22].away_team_win_probability       # => 0.172

# Miguel Rojas's game-tying HR in the 9th
wp[73].home_team_win_probability       # => 0.558
wp[73].away_team_win_probability       # => 0.442

# Will Smith's go-ahead HR in the 11th
wp[93].home_team_win_probability       # => 0.194
wp[93].away_team_win_probability       # => 0.806

# Final out - Dodgers clinch the title
wp.last.home_team_win_probability      # => 0.0
wp.last.away_team_win_probability      # => 1.0
```

### Venues

```ruby
# Get all MLB venues
venues = MLB::Venues.all(season: 2025)
venues.size                            # => 30

# Find a specific venue
citi_field = venues.find { |v| v.name == "Citi Field" }
citi_field.id                          # => 3289
citi_field.name                        # => "Citi Field"
citi_field.active?                     # => true

# Find venue by ID
citi_field = MLB::Venues.find(3289, season: 2025)
citi_field.name                        # => "Citi Field"
```

### Attendance

```ruby
# Get attendance data for a team
attendance = MLB::Attendance.find(team: MLB::Team::NYM, season: 2025)
record = attendance.first
record.team.name                       # => "New York Mets"
record.attendance_total                # => 5816527
record.attendance_average_home         # => 39316
record.attendance_high                 # => 43945
record.attendance_high_date            # => 2025-04-04 (home opener)
record.games_home_total                # => 82
```

### Game Pace

```ruby
# Get league-wide pace of play statistics
pace = MLB::GamePace.find(season: 2025)
pace.total_games                       # => 2430
pace.time_per_game                     # => "02:40:51"
pace.runs_per_game                     # => 8.89
pace.hits_per_game                     # => 16.52
pace.pitches_per_game                  # => 292.22
pace.total_extra_inn_games             # => 209
```

## Sponsorship

By contributing to the project, you help:

1. Maintain the library: Keeping it up-to-date and secure.
2. Add new features: Enhancements that make your life easier.
3. Provide support: Faster responses to issues and feature requests.

⭐️ Bonus: Sponsors will get priority support and influence over the project roadmap. We will also list your name or your company's logo on our GitHub page.

Building and maintaining an open-source project like this takes a considerable amount of time and effort. Your sponsorship can help sustain this project. Even a small monthly donation makes a huge difference!

[Click here to sponsor this project.](https://github.com/sponsors/sferik)

## Development

1. Checkout and repo:

       git checkout git@github.com:sferik/mlb-ruby.git

2. Enter the repo’s directory:

       cd mlb-ruby

3. Install dependencies via Bundler:

       bin/setup

4. Run the default Rake task to ensure all tests pass:

       bundle exec rake

5. Create a new branch for your feature or bug fix:

       git checkout -b my-new-branch

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sferik/mlb-ruby.

Pull requests will only be accepted if they meet all the following criteria:

1. Code must conform to [Standard Ruby](https://github.com/standardrb/standard#readme). This can be verified with:

       bundle exec rake standard

2. Code must conform to the [RuboCop rules](https://github.com/rubocop/rubocop#readme). This can be verified with:

       bundle exec rake rubocop

3. Code must typecheck. This can be verified with:

       bundle exec rake steep

4. 100% branch coverage. This can be verified with:

       bundle exec rake test

5. 100% mutation coverage. This can be verified with:

       bundle exec rake mutant

6. 100% documentation coverage. This can be verified with:

       bundle exec rake yardstick

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
