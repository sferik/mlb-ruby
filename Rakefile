require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

namespace :cache do
  require 'mlb'
  desc 'Update the teams file cache'
  task :update do
    doc = MLB::Team.results_from_freebase(true)
    File.open('cache/teams.json', 'w') do |file|
      file.write(doc.body)
    end
  end
end

begin
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

require 'yard'
YARD::Rake::YardocTask.new

task :default => [:spec, :rubocop]
