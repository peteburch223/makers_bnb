require 'simplecov'
SimpleCov.start

puts "starting spec_helper"

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', './app/app.rb')

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'database_cleaner'
require 'tilt/erb'
require 'helpers/test_helpers.rb'
require 'byebug'

Capybara.app = MakersBnB
  # include Capybara::DSL
  # Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.filter_run_excluding :broken => true
  config.include TestHelpers
  config.include Capybara::DSL

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  # DatabaseCleaner.clean_with(:truncation)
    # puts "DatabaseCleaner has truncated data"
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.clean
  DatabaseCleaner.start
    # puts "DatabaseCleaner has started"
  end

  config.after(:each) do
    DatabaseCleaner.clean
    # puts "DatabaseCleaner has cleaned"
  end
end
