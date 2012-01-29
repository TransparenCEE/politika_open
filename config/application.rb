# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "active_resource/railtie"
# require "rails/test_unit/railtie"
# require "sprockets/railtie"
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

ActionView::Base.field_error_proc = proc { |input, instance| input }

module Politikaopen
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
    config.autoload_paths += %W( #{config.root}/lib )
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :sk
    config.secret_token = "some secret phrase of at least 30 characters"
    config.filter_parameters << :password
  end
end
