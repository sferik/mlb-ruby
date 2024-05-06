require_relative "lib/mlb/version"

Gem::Specification.new do |spec|
  spec.name = "mlb"
  spec.version = MLB::VERSION
  spec.authors = "Erik Berlin"
  spec.email = "sferik@gmail.com"

  spec.summary = "A Ruby interface to the MLB Stats API."
  spec.homepage = "https://sferik.github.io/mlb-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.2"
  spec.platform = Gem::Platform::RUBY

  spec.add_runtime_dependency "shale", "~> 1.1"

  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "rubygems_mfa_required" => "true",
    "homepage_uri" => spec.homepage,
    "source_code_uri" => "https://github.com/sferik/mlb-ruby",
    "changelog_uri" => "https://github.com/sferik/mlb-ruby/blob/master/CHANGELOG.md",
    "bug_tracker_uri" => "https://github.com/sferik/mlb-ruby/issues",
    "documentation_uri" => "https://rubydoc.info/gems/mlb/"
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
