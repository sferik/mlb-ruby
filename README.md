# MLB.rb [![Build Status](https://secure.travis-ci.org/sferik/mlb.png?branch=master)][travis] [![Dependency Status](https://gemnasium.com/sferik/mlb.png?travis)][gemnasium]
MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.

[travis]: http://travis-ci.org/sferik/mlb
[gemnasium]: https://gemnasium.com/sferik/mlb

## Installation
    gem install mlb

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

## Contributing
In the spirit of [free software][free-sw], **everyone** is encouraged to help
improve this project.

[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, cleanup
  inconsistent whitespace)
* by refactoring code
* by closing [issues][]
* by reviewing patches

[issues]: https://github.com/sferik/mlb/issues

## Submitting an Issue
We use the [GitHub issue tracker][issues] to track bugs and features. Before
submitting a bug report or feature request, check to make sure it hasn't
already been submitted. When submitting a bug report, please include a [Gist][]
that includes a stack trace and any details that may be necessary to reproduce
the bug, including your gem version, Ruby version, and operating system.
Ideally, a bug report should include a pull request with failing specs.

[gist]: https://gist.github.com/

## Submitting a Pull Request
1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Add specs for your unimplemented feature or bug fix.
4. Run `bundle exec rake spec`. If your specs pass, return to step 3.
5. Implement your feature or bug fix.
6. Run `bundle exec rake spec`. If your specs fail, return to step 5.
7. Run `open coverage/index.html`. If your changes are not completely covered
   by your tests, return to step 3.
8. Add documentation for your feature or bug fix.
9. Run `bundle exec rake doc:yard`. If your changes are not 100% documented, go
   back to step 8.
10. Add, commit, and push your changes.
11. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

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
