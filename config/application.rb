require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Precajobs
  class Application < Rails::Application
    # config.autoload_paths += %W(#{config.root}/extras)
    config.time_zone = 'Madrid'
    config.i18n.default_locale = :es
    config.encoding = "utf-8"
    config.i18n.fallbacks = [:en]

    config.filter_parameters += [:password]

    config.assets.enabled = true
    config.assets.version = '1.0'
    # config.assets.prefix = "/assets"

  end
end
