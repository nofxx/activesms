require 'activesms/connection_adapters/abstract_adapter'

module ActiveSms
  class Base
    def self.clickatell_connection(config) #:nodoc:
      return ConnectionAdapters::ClickatellAdapter.new(logger, config)
    end
  end
  
  module ConnectionAdapters
    class ClickatellAdapter < AbstractAdapter

      SERVICE_HOST = "api.clickatell.com"
      SERVICE_PATH = "/http/sendmsg"
      
      # Create an adapter for the Clickatell gateway.
      #
      # Options:
      #
      # * <tt>:user</tt>
      # * <tt>:password</tt>
      # * <tt>:api_id</tt>
      # * <tt>use_ssl</tt>
      def initialize(logger = nil, config = {})
        super(logger)
        @config = config.dup
        
        scheme = config[:use_ssl] ? "https" : "http"
        @service_url = "#{scheme}://#{SERVICE_HOST}#{SERVICE_PATH}"
      end
      
      # Return the human readable name of the gateway adapter name.
      def adapter_name
        return 'Clickatell'
      end
      
      def deliver(sms)
        params = {
          :user     => @config[:user],
          :password => @config[:password],
          :api_id   => @config[:api_id],
          :to       => sms.recipients,
          :from     => sms.from,
          :text     => sms.body
        }
        send_http_request(@service_url, params)
      end
    end
    
  end
end
