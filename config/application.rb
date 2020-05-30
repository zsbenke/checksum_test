require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    I18n.available_locales = [:hu]
    config.beginning_of_week = :monday
    config.i18n.default_locale = :hu
    config.time_zone = 'Budapest'
    config.host = config_for(:host)
  end
end
