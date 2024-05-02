[![Tests](https://github.com/sferik/mlb-ruby/actions/workflows/test.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/test.yml)
[![Linter](https://github.com/sferik/mlb-ruby/actions/workflows/lint.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/lint.yml)
[![Mutant](https://github.com/sferik/mlb-ruby/actions/workflows/mutant.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/mutant.yml)
[![Typer Checker](https://github.com/sferik/mlb-ruby/actions/workflows/steep.yml/badge.svg)](https://github.com/sferik/mlb-ruby/actions/workflows/steep.yml)
[![Gem Version](https://badge.fury.io/rb/mlb.svg)](https://rubygems.org/gems/mlb)

# A [Ruby](https://www.ruby-lang.org) interface to the [MLB Data API](https://appac.github.io/mlb-data-api-docs/)

## Follow

For updates and announcements, follow [@sferik](https://x.com/sferik) on X.

## Installation

Install the gem and add to the application's Gemfile:

    bundle add mlb

Or, if Bundler is not being used to manage dependencies:

    gem install mlb

## Usage

```ruby
require "mlb"

dbacks = MLB::Team.all(season: 2024).first
dbacks.name_display_full       # => "Arizona Diamondbacks"
dbacks.name_display_brief      # => "D-backs"
dbacks.name_abbrev             # => "AZ"
dbacks.city                    # => "Phoenix"
dbacks.league_full             # => "National League"
dbacks.league_abbrev           # => "NL"
dbacks.spring_league_full      # => "Cactus League"
dbacks.spring_league_abbrev    # => "CL"
dbacks.division_full           # => "National League West"
dbacks.division_abbrev         # => "NLW"
dbacks.first_year_of_play      # => "1996"
dbacks.venue_name              # => "Chase Field"

blaze = dbacks.roster.first
blaze.name_display_first_last  # => "Blaze Alexander"
blaze.jersey_number            # => "9"
blaze.primary_position         # => "6"
blaze.position_txt             # => "SS"
blaze.height_feet              # => "5"
blaze.height_inches            # => "11"
blaze.weight                   # => "160"
blaze.bats                     # => "R"
blaze.throws                   # => "R"
blaze.birth_date               # => "1999-06-11T00:00:00"
blaze.start_date               # => "2022-11-15T00:00:00"
blaze.pro_debut_date           # => "2024-03-28T00:00:00"
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

3. 100% C0 code coverage. This can be verified with:

       bundle exec rake test

4. 100% mutation coverage. This can be verified with:

       bundle exec rake mutant

5. RBS type signatures (in `sig/mlb.rbs`). This can be verified with:

       bundle exec rake steep

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
