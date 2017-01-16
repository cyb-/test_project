require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Paydev
  class Application < Rails::Application
    config.i18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:fr, :en]
    config.i18n.default_locale = :en
  end
end
