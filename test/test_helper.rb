$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

unless $PROGRAM_NAME.end_with?("mutant")
  require "simplecov"
  require "simplecov_json_formatter"

  SimpleCov.start do
    add_filter "test"
    formatter SimpleCov::Formatter::JSONFormatter if ENV["GITHUB_ACTIONS"]
    minimum_coverage(100)
  end
end

require "minitest/autorun"
require "mutant/minitest/coverage"
require "webmock/minitest"
require "mlb"
