# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mlb/version", __FILE__)

Gem::Specification.new do |s|
  s.add_development_dependency("bundler", "~> 1.0")
  s.add_development_dependency("rake", "~> 0.8")
  s.add_development_dependency("rcov", "~> 0.9")
  s.add_development_dependency("rspec", "~> 2.0")
  s.add_development_dependency("webmock", "~> 1.5")
  s.add_development_dependency("ZenTest", "~> 4.4")
  s.add_runtime_dependency("httparty", ["~> 0.6"])
  s.add_runtime_dependency("json", ["~> 1.4"])
  s.add_runtime_dependency("sqlite3-ruby", ["~> 1.3"])
  s.authors = ["Erik Michaels-Ober"]
  s.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.email = ["sferik@gmail.com"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "http://rubygems.org/gems/mlb"
  s.name = "mlb"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.summary = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = MLB::VERSION
end
