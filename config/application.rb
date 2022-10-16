require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.time_zone = "Ekaterinburg"
    config.i18n.default_locale = :en

    config.autoload_paths << "#{Rails.root}/lib/clients"
    config.autoload_paths << "#{Rails.root}/lib/badge_rules"
    config.autoload_paths << "#{Rails.root}/lib/badge_rules/rules"
    config.autoload_paths << "#{Rails.root}/lib/modules"

    # config.eager_load_paths << Rails.root.join("extras")
  end
end
