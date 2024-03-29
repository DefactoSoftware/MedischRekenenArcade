require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'leaderboard'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module MedischRekenenArcade
  class Application < Rails::Application
    config.filepicker_rails.api_key = ENV['FILEPICKER_API_KEY']

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir[Rails.root.join("app/models/**")]


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    I18n.enforce_available_locales = false
    config.serve_static_assets = true

    config.active_record.observers = [:badges_sash_observer,
                                      :answers_observer,
                                      :user_challenges_observer,
                                      :users_observer]

    I18n.default_locale = :en
  end
end
