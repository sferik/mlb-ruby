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
teams.size                  # => 30

mets = teams.find { |t| t.abbreviation == "NYM" }
mets.name                   # => "New York Mets"
mets.short_name             # => "NY Mets"
mets.abbreviation           # => "NYM"
mets.league.name            # => "National League"
mets.division.name          # => "National League East"
mets.first_year_of_play     # => 1962
mets.venue.name             # => "Citi Field"
```

### Players

```ruby
# Find a player by ID
senga = MLB::Players.find(807882)
senga.full_name              # => "Kodai Senga"
senga.primary_number         # => 34
senga.primary_position.name  # => "Pitcher"
senga.pitch_hand.description # => "Right"
senga.bat_side.description   # => "Right"
senga.current_age            # => 32
senga.birth_date.to_s        # => "1993-01-30"
senga.birth_city             # => "Nagaoka"
senga.birth_state_province   # => "Niigata"
senga.birth_country          # => "Japan"
senga.mlb_debut_date.to_s    # => "2023-04-01"
senga.height                 # => "6' 1\""
senga.weight                 # => 200
senga.active?                # => true
```

### Schedule

```ruby
# Get games for a specific date
games = MLB::Schedule.games(date: Date.new(2025, 6, 14))
games.size                       # => 15

# Get games for a specific team
mets_games = MLB::Schedule.games(date: Date.new(2025, 6, 14), team: 121)
game = mets_games.first
game.game_pk                     # => 778517
game.official_date.to_s          # => "2025-06-14"
game.status.detailed_state       # => "Final"
game.venue.name                  # => "Citi Field"
game.day_night                   # => "day"
game.series_description          # => "Regular Season"
game.teams.away.team.name        # => "San Diego Padres"
game.teams.home.team.name        # => "New York Mets"
game.teams.away.score            # => 3
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
mets.games_back                        # => "12.0"
mets.runs_scored                       # => 730
mets.runs_allowed                      # => 715
mets.run_differential                  # => 15
mets.division_rank                     # => "2"
mets.streak.streak_code                # => "L1"
```

### League Leaders

```ruby
# Get home run leaders
hr_leaders = MLB::Leaders.find(category: "homeRuns", season: 2025, limit: 5)
hr_leaders.size                        # => 5

leader = hr_leaders.first
leader.rank                            # => 1
leader.value                           # => "60"
leader.person.full_name                # => "Cal Raleigh"
leader.team.name                       # => "Seattle Mariners"

# Get batting average leaders
avg_leaders = MLB::Leaders.find(category: "battingAverage", season: 2025, limit: 3)
avg_leaders.first.person.full_name     # => "Aaron Judge"
avg_leaders.first.value                # => ".331"

# Get wins leaders for pitchers
wins_leaders = MLB::Leaders.find(category: "wins", season: 2025, limit: 3)
wins_leaders.first.person.full_name    # => "Max Fried"
wins_leaders.first.value               # => "19"
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
first_pick.school.school_class         # => "HS"
first_pick.pick_value                  # => "11075900"
first_pick.signing_bonus               # => "6500000"
```

### Transactions

```ruby
# Get transactions for a date range
transactions = MLB::Transactions.between(
  start_date: Date.new(2025, 7, 29),
  end_date: Date.new(2025, 7, 29)
)
transactions.size                      # => 42

# Find a specific transaction
trade = transactions.find { |t| t.player.full_name == "Luis Severino" }
trade.type_desc                        # => "Trade"
trade.player.full_name                 # => "Luis Severino"
trade.from_team.name                   # => "New York Mets"
trade.to_team.name                     # => "Oakland Athletics"
trade.description                      # => "Oakland Athletics acquired RHP Luis Severino from New York Mets..."
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

### Win Probability

```ruby
# Get win probability data for 2025 World Series Game 7
# Dodgers vs Blue Jays at Rogers Centre (Dodgers won 5-4 in 11 innings)
wp = MLB::WinProbability.find(game: 795514)
wp.size                                # => 87

# Probability at game start (home team Blue Jays slight favorites)
wp.first.at_bat_index                  # => 0
wp.first.home_team_win_probability     # => 0.531
wp.first.away_team_win_probability     # => 0.469

# After Bo Bichette's 3-run HR in the 3rd, Blue Jays led 3-1
wp[24].home_team_win_probability       # => 0.812
wp[24].away_team_win_probability       # => 0.188

# 9th inning, 2 outs - Blue Jays one out from winning
wp[72].home_team_win_probability       # => 0.964
wp[72].away_team_win_probability       # => 0.036

# After Miguel Rojas's game-tying HR in the 9th
wp[73].home_team_win_probability       # => 0.498
wp[73].away_team_win_probability       # => 0.502

# After Will Smith's walk-off HR in the 11th
wp.last.home_team_win_probability      # => 0.0
wp.last.away_team_win_probability      # => 1.0
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
