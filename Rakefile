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

require 'rake/rdoctask'
Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.include('README.rdoc', 'LICENSE', 'lib/**/*.rb')
  rd.title = 'MLB.rb'
  rd.options << '--inline-source'
  rd.options << '--all'
end
