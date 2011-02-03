require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

namespace :doc do
  require 'yard'
  YARD::Rake::YardocTask.new do |task|
    task.files   = ['LICENSE.mkd', 'lib/**/*.rb']
    task.options = [
      '--output-dir', 'doc/yard',
      '--markup', 'markdown',
    ]
  end
end

namespace :cache do
  require File.expand_path('../lib/mlb', __FILE__)
  desc "Update the teams file cache"
  task :update do
    doc = MLB::Team.results_from_freebase(true)
    File.open('cache/teams.json', 'w') do |file|
      file.write(doc.body)
    end
  end
end
