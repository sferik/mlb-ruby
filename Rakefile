require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'rake/rdoctask'

GEM_NAME = "mlb"
AUTHOR = "Erik Michaels-Ober"
EMAIL = "sferik@gmail.com"
HOMEPAGE = "http://github.com/sferik/mlb"
SUMMARY = "MLB.rb is a Ruby library for retrieving current Major League Baseball players, managers, teams, divisions, and leagues."
GEM_VERSION = "0.0.4"

spec = Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency("httparty", ">= 0.4.5")
  s.add_dependency("json", ">= 1.1.9")
  s.require_path = "lib"
  s.files = %w(LICENSE README.rdoc Rakefile) + Dir.glob("{doc,lib}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.include('README.rdoc', 'LICENSE', 'lib/**/*.rb')
  rd.title = 'MLB.rb'
  rd.options << '--inline-source'
  rd.options << '--all'
end
