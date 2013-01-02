# encoding: utf-8
require File.expand_path('../lib/mlb/version', __FILE__)

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', '~> 0.8'
  spec.add_dependency 'faraday_middleware', '~> 0.8'
  spec.add_dependency 'multi_json', '~> 1.3'
  spec.author = "Erik Michaels-Ober"
  spec.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  spec.email = 'sferik@gmail.com'
  spec.files = `git ls-files`.split("\n")
  spec.homepage = 'https://github.com/sferik/mlb'
  spec.homepage = ['MIT']
  spec.name = 'mlb'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  spec.summary = spec.description
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.version = MLB::VERSION
end
