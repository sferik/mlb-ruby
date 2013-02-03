# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mlb/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', '~> 0.8'
  spec.add_dependency 'faraday_middleware', '~> 0.8'
  spec.add_dependency 'multi_json', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.author = "Erik Michaels-Ober"
  spec.cert_chain  = ['public_cert.pem']
  spec.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  spec.email = 'sferik@gmail.com'
  spec.files = %w(.yardopts CONTRIBUTING.md LICENSE.md README.md Rakefile mlb.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'https://github.com/sferik/mlb'
  spec.homepage = ['MIT']
  spec.name = 'mlb'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.6'
  spec.required_ruby_version = '>= 1.9.2'
  spec.signing_key = '/Users/sferik/.gem/private_key.pem'
  spec.summary = spec.description
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.version = MLB::VERSION
end
