require "bundler/gem_tasks"

# Override release task to skip gem push (handled by GitHub Actions with attestations)
Rake::Task["release"].clear
desc "Build gem and create tag (gem push handled by CI)"
task release: %w[build release:guard_clean release:source_control_push]

require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.options = "--pride"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "standard/rake"
require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run linters"
task lint: %i[rubocop standard]

require "mutant"

desc "Run mutant"
task :mutant do
  system(*%w[bundle exec mutant run]) or raise "Mutant task failed"
end

require "steep/rake_task"

Steep::RakeTask.new(:steep)

require "yard"

desc "Generate YARD documentation"
task :yard do
  require "open3"
  stdout, stderr, status = Open3.capture3("bundle", "exec", "yard", "doc")

  # Filter out multi-line "Undocumentable mixin" warnings for Equalizer.new
  equalizer_warning = /
    \[warn\]:\sin\sYARD::Handlers::Ruby::MixinHandler:\s
    Undocumentable\smixin[^\n]*\n
    \tin\sfile[^\n]*\n
    \n
    \t\d+:\sinclude\sEqualizer\.new[^\n]*\n
    \n
  /x
  filtered = stdout.gsub(equalizer_warning, "")

  print filtered
  print stderr unless stderr.strip.empty?
  exit status.exitstatus unless status.success?
end

require "yardstick/rake/verify"

Yardstick::Rake::Verify.new(:yardstick) do |verify|
  verify.threshold = 100
end

task default: %i[test lint mutant steep yardstick]
