MLB.rb
======
MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.

Installation
------------
    gem install mlb

Documentation
-------------
<http://rdoc.info/gems/mlb>

Continuous Integration
----------------------
[![Build Status](http://travis-ci.org/sferik/mlb.png)](http://travis-ci.org/sferik/mlb)

Usage Examples
-----
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

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, cleanup inconsistent whitespace)
* by refactoring code
* by closing [issues](http://github.com/sferik/mlb/issues)
* by reviewing patches
* financially

All contributors will be added to the credits and will receive the respect and gratitude of the community.

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/sferik/mlb/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

Credits
-------
Many thanks to:

* [Bundler](http://gembundler.com/)
* [Freebase](http://www.freebase.com/)
* [Faraday](https://github.com/technoweenie/faraday/)
* [Markdown](http://daringfireball.net/projects/markdown/)
* [MultiJSON](https://github.com/intridea/multi_json/)
* [RSpec](http://relishapp.com/rspec/)
* [SimpleCov](https://github.com/colszowka/simplecov)
* [SQLite](http://www.sqlite.org/)
* [WebMock](https://github.com/bblimke/webmock/)
* [YARD](http://yardoc.org/)