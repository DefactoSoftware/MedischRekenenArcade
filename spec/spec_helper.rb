# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require "simplecov"
SimpleCov.start
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "database_cleaner"
require "capybara/rspec"
require "ruby-debug" if Gem::Specification::find_all_by_name("ruby-debug").any?

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  ### DatabaseCleaner configuration
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    FactoryGirl.reload
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    RedisLeaderboard.get.delete_leaderboard
  end

  config.include Devise::TestHelpers, type: :controller
end

RspecApiDocumentation.configure do |config|
  config.format = :json
end

Raddocs.configure do |config|
  config.docs_dir = "doc/api"
end
