require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  desc "Run all examples using rcov"
  RSpec::Core::RakeTask.new(:rcov => :cleanup_rcov_files) do |task|
    task.rcov = true
    task.rcov_opts = %[-Ilib -Ispec --exclude "gems/*,features,specs" --text-report --sort coverage]
  end
end

task :cleanup_rcov_files do
  rm_rf 'coverage'
end

task :default => ["spec:rcov"]

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
