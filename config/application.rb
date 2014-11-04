require File.expand_path('../boot', __FILE__)

# load app_config.yml  
# require 'yaml'  
# APP_CONFIG = YAML.load(File.read(File.expand_path('../app_config.yml', __FILE__)))  

require 'rails/all'
require 'translator'

Bundler.require(:default, ::Rails.env) if defined?(Bundler)

module Fedena
  class Application < Rails::Application
    config.autoload_paths += [config.root.join('lib')]
    config.encoding = 'utf-8'
    config.time_zone = 'UTC'
    config.filter_parameters += [:password]
    config.gem 'declarative_authorization', :source => 'http://gemcutter.org'
  
    #config.load_once_paths += %W( #{RAILS_ROOT}/lib )
    config.autoload_paths += %W(#{Rails.root}/lib) 
    config.autoload_paths += Dir["#{::Rails.root.to_s}/app/models/*"].find_all { |f| File.stat(f).directory? }
  
    config.reload_plugins = true if RAILS_ENV =="development"
    config.plugins = [:paperclip,:all]
  
    if (File.exist?('config/smtp_settings.yml'))
      SMTP_SETTINGS = YAML.load_file('config/smtp_settings.yml')[RAILS_ENV]
      if SMTP_SETTINGS      
        config.action_mailer.delivery_method = :smtp
        config.action_mailer.smtp_settings = SMTP_SETTINGS
      end
    end
  end
end
