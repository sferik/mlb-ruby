# encoding: utf-8
require File.expand_path('../lib/mlb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'faraday', '~> 0.7'
  gem.add_dependency 'faraday_middleware', '~> 0.8'
  gem.add_dependency 'json', '~> 1.6'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdiscount'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.author = "Erik Michaels-Ober"
  gem.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  gem.email = 'sferik@gmail.com'
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/sferik/mlb'
  gem.name = 'mlb'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = gem.description
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = MLB::VERSION
end
