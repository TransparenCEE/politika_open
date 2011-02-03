# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

ActionView::Base.field_error_proc = proc { |input, instance| input }

module Politikaopen
  class Application < Rails::Application
    config.autoload_paths += %W( #{config.root}/lib )
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :sk
    config.secret_token = "some secret phrase of at least 30 characters"
    config.filter_parameters << :password
  end
end
