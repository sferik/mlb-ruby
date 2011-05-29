$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'mlb'
require 'rspec'
require 'webmock/rspec'

def fixture_path
  File.expand_path("../../cache", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
