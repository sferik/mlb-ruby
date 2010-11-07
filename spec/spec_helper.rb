require File.expand_path('../../lib/mlb', __FILE__)

require 'webmock/rspec'
# This is a hack! Remove after the next version of webmock is released
# @see http://groups.google.com/group/webmock-users/browse_thread/thread/82d01290b8bbff77
require 'json'
RSpec.configure do |config|
  config.include WebMock::API
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
