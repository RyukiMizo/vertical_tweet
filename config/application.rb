require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
#config.assets.initialize_on_precompile = false
module VerticalTweet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    config.action_view.embed_authenticity_token_in_remote_forms = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.test_framework :rspec,
      view_specs: false,
      # フィーチャスペックで UI をテスト
      helper_specs: false,
      routing_specs: false,
      request_spec: false
    end
  end
end
