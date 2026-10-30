require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PokemonRainbow
  class Application < Rails::Application
    config.load_defaults 8.1

    # Rails 5.0 never applied this default; surrender battle logs have no skill, so keep belongs_to optional.
    config.active_record.belongs_to_required_by_default = false

    # lib/battle_engine.rb and lib/pokemon_battle_calculator.rb are autoloaded.
    config.autoload_lib(ignore: %w[assets seeds tasks])

    config.i18n.available_locales = [:en, :id]
    config.i18n.default_locale = :en
  end
end
