require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

namespace :cache do
  require 'mlb'
  desc 'Update the teams file cache'
  task :update do
    json = MLB::Team.results_from_freebase
    file = File.new('cache/teams.json', 'w+')
    tempfile = Tempfile.new('teams.json')
    tempfile.write(JSON.dump(json))
    if system("python -mjson.tool #{tempfile.path} #{file.path}")
      puts "File sucessfully written to #{file.path}"
      tempfile.delete
    else
      abort "Error parsing #{tempfile.path}"
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

require 'yardstick/rake/measurement'
Yardstick::Rake::Measurement.new do |measurement|
  measurement.output = 'measurement/report.txt'
end

require 'yardstick/rake/verify'
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 56.0
end

task :default => [:spec, :rubocop, :verify_measurements]
