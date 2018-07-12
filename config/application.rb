require_relative 'boot'

require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Infotos
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths << Rails.root.join('app/services')

    cache_server = YAML.load(File.read(Rails.root.join('config', 'redis.yml'))).symbolize_keys
    cache_server.merge!(driver: :hiredis)

    config.cache_store = :redis_cache_store, cache_server

  end
end
