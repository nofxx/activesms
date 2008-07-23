require 'yaml'

module ActiveSms #:nodoc#  
    # #
    # Check out if we are on rails 
    # if not, use default yml with only email
    RAILS_CONFIG_ROOT = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/config" : "#{File.dirname(__FILE__)}/../../generators/sms/templates" unless defined?(RAILS_CONFIG_ROOT)
    # and load what we have!
    conf_yml ||= YAML::load(File.open("#{RAILS_CONFIG_ROOT}/sms.yml")) 

    # #
    # Get general parameters
    CONFIG = conf_yml['config']
    
    # #
    # Get the configured gateway
    GATEWAY = conf_yml['gateway']
    
    # #
    # Get all carriers
    CARRIERS = conf_yml['carriers'] 
                  
    # #
    # Establish a connection if we have yml parameters
    ActiveSms::Base.establish_connection(GATEWAY) if GATEWAY
        
end
