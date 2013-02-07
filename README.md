# MLB.rb
[![Gem Version](https://badge.fury.io/rb/mlb.png)][gem]
[![Build Status](https://secure.travis-ci.org/sferik/mlb.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/sferik/mlb.png?travis)][gemnasium]

[gem]: https://rubygems.org/gems/mlb
[travis]: http://travis-ci.org/sferik/mlb
[gemnasium]: https://gemnasium.com/sferik/mlb

MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.

## Installation
    gem install mlb

To ensure the code you're installing hasn't been tampered with, it's
recommended that you verify the signature. To do this, you need to add my
public key as a trusted certificate (you only need to do this once):

    gem cert --add <(curl -Ls https://gist.github.com/sferik/4701180/raw/public_cert.pem)

Then, install the gem with the high security trust policy:

    gem install mlb -P HighSecurity

## Documentation
[http://rdoc.info/gems/mlb][documentation]

[documentation]: http://rdoc.info/gems/mlb

## Usage Examples
    $ irb
    >> require 'mlb'
    >> MLB::Team.all.first.name                   # => "Arizona Diamondbacks"
    >> MLB::Team.all.first.league                 # => "National League"
    >> MLB::Team.all.first.division               # => "National League West"
    >> MLB::Team.all.first.manager                # => "Bob Melvin"
    >> MLB::Team.all.first.wins                   # => 82
    >> MLB::Team.all.first.losses                 # => 80
    >> MLB::Team.all.first.founded                # => 1998
    >> MLB::Team.all.first.mascot                 # => nil
    >> MLB::Team.all.first.ballpark               # => "Chase Field"
    >> MLB::Team.all.first.logo_url               # => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/en_id/13104064"
    >> MLB::Team.all.first.players.first.name     # => "Alex Romero"
    >> MLB::Team.all.first.players.first.number   # => 28
    >> MLB::Team.all.first.players.first.position # => "Right fielder"

## Supported Ruby Versions
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.9.2
* Ruby 1.9.3
* [Rubinius][]

[rubinius]: http://rubini.us/

If something doesn't work on one of these interpreters, it should be considered
a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be personally responsible for providing patches in a
timely fashion. If critical issues for a particular implementation exist at the
time of a major release, support for that Ruby version may be dropped.

## Colophon
MLB was built with the following tools:

* [Bundler][]
* [Freebase][]
* [Faraday][]
* [Markdown][]
* [MultiJSON][]
* [RSpec][]
* [SimpleCov][]
* [SQLite][]
* [vim][]
* [WebMock][]
* [YARD][]

[bundler]: http://gembundler.com/
[freebase]: http://www.freebase.com/
[faraday]: https://github.com/technoweenie/faraday
[markdown]: http://daringfireball.net/projects/markdown/
[multijson]: https://github.com/intridea/multi_json
[rspec]: http://relishapp.com/rspec/
[simplecov]: https://github.com/colszowka/simplecov
[sqlite]: http://www.sqlite.org/
[vim]: http://www.vim.org/
[webmock]: https://github.com/bblimke/webmock
[yard]: http://yardoc.org/

## Copyright
Copyright (c) 2010 Erik Michaels-Ober. See [LICENSE][] for details.

[license]: https://github.com/sferik/mlb/blob/master/LICENSE.md
