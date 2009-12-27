require 'rubygems'
require 'rake'
require 'rake/rdoctask'

GEM_NAME = "mlb"
AUTHOR = "Erik Michaels-Ober"
EMAIL = "sferik@gmail.com"
HOMEPAGE = "http://github.com/sferik/mlb"
SUMMARY = "MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues."

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = GEM_NAME
    gemspec.summary = SUMMARY
    gemspec.description = gemspec.summary
    gemspec.author = AUTHOR
    gemspec.email = EMAIL
    gemspec.homepage = HOMEPAGE
    gemspec.add_dependency("httparty", ">= 0.5.0")
    gemspec.add_dependency("json", ">= 1.2.0")
    gemspec.add_dependency("sqlite3-ruby", ">= 1.2.5")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.include('README.rdoc', 'LICENSE', 'lib/**/*.rb')
  rd.title = 'MLB.rb'
  rd.options << '--inline-source'
  rd.options << '--all'
end
