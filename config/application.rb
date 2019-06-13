require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OrthologyDb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += %W(#{config.root}/lib)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Do not swallow errors in after_commit/after_rollback callbacks.
    # I believe this behaviour was added between 4.1 and 4.2 as a temporary solution to a problem which is no longer relevant in rails 5
    # https://stackoverflow.com/questions/37464966/what-causes-deprecation-warning-activerecordbase-raise-in-transactional-callb
    # config.active_record.raise_in_transactional_callbacks = true
  end
end
