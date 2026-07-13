$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

unless $PROGRAM_NAME.end_with?("mutant")
  require "simplecov"

  SimpleCov.start do
    skip "test"
    enable_coverage :branch
    formatter SimpleCov::Formatter::JSONFormatter if ENV["GITHUB_ACTIONS"]
    minimum_coverage line: 100, branch: 100
  end
end

require "minitest/autorun"
require "minitest/mock"
require "mutant/minitest/coverage"
require "webmock/minitest"
require "mlb"
