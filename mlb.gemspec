# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mlb/version', __FILE__)

Gem::Specification.new do |s|
  s.add_development_dependency('bundler', '~> 1.0')
  s.add_development_dependency('json', '~> 1.5')
  s.add_development_dependency('maruku', '~> 0.6')
  s.add_development_dependency('rake', '~> 0.8')
  s.add_development_dependency('rspec', '~> 2.3')
  s.add_development_dependency('simplecov', '~> 0.3')
  s.add_development_dependency('webmock', '~> 1.6')
  s.add_development_dependency('yard', '~> 0.6')
  s.add_development_dependency('ZenTest', '~> 4.4')
  s.add_runtime_dependency('faraday', '~> 0.5.3')
  s.add_runtime_dependency('faraday_middleware', '~> 0.3.1')
  s.add_runtime_dependency('multi_json', '~> 0.0.5')
  s.authors = ["Erik Michaels-Ober"]
  s.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.email = ['sferik@gmail.com']
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.homepage = 'http://rubygems.org/gems/mlb'
  s.name = 'mlb'
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ['lib']
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to? :required_rubygems_version=
  s.summary = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = MLB::VERSION
end
