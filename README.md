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

mets = MLB::Teams.all(season: 2024).last
mets.name                   # => "New York Mets"
mets.short_name             # => "NY Mets"
mets.abbreviation           # => "NYM"
mets.league.name            # => "National League"
mets.spring_league.name     # => "Grapefruit League"
mets.division.name          # => "National League East"
mets.first_year_of_play     # => 1962
mets.location_name          # => "Flushing"
mets.venue.name             # => "Citi Field"

adam = MLB::Players.find(mets.roster.first.player)

adam.full_name              # => "Adam Ottavino"
adam.primary_number         # => 0
adam.primary_position.name  # => "Pitcher"
adam.pitch_hand.description # => "Right"
adam.bat_side.description   # => "Switch"
adam.current_age            # => 38
adam.birth_date.to_s        # => "1985-11-22"
adam.birth_city             # => "New York"
adam.birth_state_province   # => "NY"
adam.birth_country          # => "USA"
adam.draft_year             # => 2006
adam.mlb_debut_date.to_s    # => "2010-05-29"
adam.height                 # => "6' 5\""
adam.weight                 # => 246
adam.active?                # => true
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
