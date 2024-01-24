# frozen_string_literal: true

require 'cucumber/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.allow_remote_database_url = true

Capybara.app_host = 'http://localhost:5000'

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

ActionController::Base.allow_rescue = false

begin
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
