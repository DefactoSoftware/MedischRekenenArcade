source 'https://rubygems.org'
ruby '2.1.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
gem 'rails-observers'
# Use Postgress as the database for Active Record
gem 'pg'

#Merit, for badges
gem 'merit', '~> 1.7.0'

#Redis leaderboard
gem 'leaderboard'

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

gem 'activeadmin', github: 'gregbell/active_admin'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  #for Heroku
  gem 'rails_12factor'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'capybara'
end

group :development do
  gem 'annotate'
  gem 'debugger'
end

group :test do
  gem 'guard-rspec'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'factory_girl_rails'
  gem 'simplecov', :require => false
  gem 'json_spec'
  gem 'rake'
end

group :test, :darwin do
  gem 'rb-fsevent'
end
