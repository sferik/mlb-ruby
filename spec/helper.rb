require 'simplecov'
SimpleCov.start do
  add_group 'Libraries', 'lib'
end
require 'mlb'
require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def fixture_path
  File.expand_path("../../cache", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
