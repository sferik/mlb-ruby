# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mlb/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  spec.add_dependency 'json', '~> 1.8'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.author = 'Erik Michaels-Ober'
  spec.cert_chain  = ['certs/sferik.pem']
  spec.description = %q{MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues.}
  spec.email = 'sferik@gmail.com'
  spec.files = %w(.yardopts CONTRIBUTING.md LICENSE.md README.md Rakefile mlb.gemspec)
  spec.files += Dir.glob('lib/**/*.rb')
  spec.files += Dir.glob('spec/**/*')
  spec.homepage = 'https://github.com/sferik/mlb'
  spec.licenses = ['MIT']
  spec.name = 'mlb'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.5'
  spec.signing_key = File.expand_path('~/.gem/private_key.pem') if $PROGRAM_NAME =~ /gem\z/
  spec.summary = spec.description
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.version = MLB::VERSION
end
