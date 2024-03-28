# frozen_string_literal: true

require 'cucumber/rails'
require 'database_cleaner'
require 'capybara/cuprite'
require 'warden/test/helpers'

World(Warden::Test::Helpers)

Warden.test_mode!

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.allow_remote_database_url = true

Before do
  DatabaseCleaner.start
  puts Capybara.current_driver
end

After do
  DatabaseCleaner.clean
  Warden.test_reset!
end

ActionController::Base.allow_rescue = false

begin
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.javascript_driver = :cuprite

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, browser_options: { 'no-sandbox': nil }, window_size: [1200, 800])
end

