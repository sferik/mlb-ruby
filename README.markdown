# MLB.rb

**MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.**

## Get it

At the command prompt, type:

    sudo gem install mlb -s http://gemcutter.org

## Use it

    $ irb
    >> require 'mlb'
    => true
    >> team = MLB.teams[17]; nil
    => nil
    >> team.name
    => "New York Mets"
    >> team.league
    => "National League"
    >> team.division
    => "National League East"
    >> team.manager
    => "Jerry Manuel"
    >> team.wins
    => 89
    >> team.losses
    => 73
    >> team.founded
    => 1962
    >> team.mascot
    => "Mr. Met"
    >> team.ballpark
    => "Shea Stadium"
    >> team.logo_url
    => "http://img.freebase.com/api/trans/image_thumb/wikipedia/images/commons_id/3269938"
    >> player = team.players[14]; nil
    => nil
    >> player.name
    => "David Wright"
    >> player.number
    => 5
    >> player.position
    => "Third baseman"

Many thanks to:

* [Freebase](http://www.freebase.com)
* [httparty](http://github.com/jnunemaker/httparty)

Also, thanks to [beer](http://www.21st-amendment.com).
