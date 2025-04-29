require_relative "lib/mlb/version"

Gem::Specification.new do |spec|
  spec.name = "mlb"
  spec.version = MLB::VERSION
  spec.authors = "Erik Berlin"
  spec.email = "sferik@gmail.com"

  spec.summary = "A Ruby interface to the MLB Stats API."
  spec.homepage = "https://sferik.github.io/mlb-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"
  spec.platform = Gem::Platform::RUBY

  spec.add_dependency "equalizer", "~> 0.0.11"
  spec.add_dependency "shale", "~> 1.1"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri" => "https://github.com/sferik/mlb-ruby/issues",
    "changelog_uri" => "https://github.com/sferik/mlb-ruby/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/mlb/",
    "funding_uri" => "https://github.com/sponsors/sferik/",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/sferik/mlb-ruby"
  }

  spec.files = Dir[
    "bin/*",
    "lib/**/*.rb",
    "sig/*.rbs",
    "*.md",
    "LICENSE.txt"
  ]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
