source 'https://rubygems.org'
ruby '2.1.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.4'
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
gem 'rails-observers'
# Use Postgress as the database for Active Record
gem 'pg'

#Server
gem 'unicorn'

#Doorkeeper, OAUTH
gem 'doorkeeper'

#Merit, for badges
gem 'merit', '~> 1.7.0'

#Redis leaderboard
gem 'leaderboard'

#Hashtel colors
gem 'hashtel'

gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Use Devise for user management
gem 'devise'

#Monitoring
gem 'newrelic_rpm'

gem 'filepicker-rails', '~> 1.0.0'

gem 'redcarpet'

gem 'formtastic', github: 'justinfrench/formtastic'
gem 'ransack', github: 'activerecord-hackery/ransack', branch: 'rails-4.1'
gem 'polyamorous', github: 'activerecord-hackery/polyamorous'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'minitest'

gem 'raddocs'

gem "active_model_serializers"

gem 'dotenv-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  #for Heroku
  gem 'rails_12factor'
  gem "rack-timeout"
end

group :test, :development do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec_api_documentation', :github => 'zipmark/rspec_api_documentation'
  gem 'capybara', "~> 2.3.0"
end

group :development do
  gem 'annotate'
  gem 'debugger'
end

group :test do
  gem 'guard-rspec'
  gem 'shoulda-matchers', '~> 2.6.0'
  gem 'simplecov', :require => false
  gem 'json_spec'
  gem 'rake'
end

group :test, :darwin do
  gem 'rb-fsevent'
end
