source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use Postgress as the database for Active Record
gem 'pg'

#Redis leaderboard
gem 'leaderboard'

gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Use Devise for user management
gem 'devise'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

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
end

group :test do
  gem 'guard-rspec'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'factory_girl_rails'
  gem 'simplecov', :require => false
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'json_spec'
  gem 'rake'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

group :debug do
  gem 'debugger'
end
