# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mlb/version", __FILE__)

Gem::Specification.new do |s|
  s.add_runtime_dependency(%q<httparty>, ["~> 0.6"])
  s.add_runtime_dependency(%q<json>, ["~> 1.4"])
  s.add_runtime_dependency(%q<sqlite3-ruby>, ["~> 1.3"])
  s.authors = ["Erik Michaels-Ober"]
  s.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.email = ["sferik@gmail.com"]
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "http://rubygems.org/gems/mlb"
  s.name = "mlb"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_rubygems_version = ">= 1.3.6"
  s.summary = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = MLB::VERSION
end
