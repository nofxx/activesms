require 'activesms/connection_adapters/abstract_adapter'

module ActiveSms
  class Base
    def self.bulk_sms_connection(config) #:nodoc:
      return ConnectionAdapters::BulkSmsAdapter.new(logger, config)
    end
  end
  
  module ConnectionAdapters
    class BulkSmsAdapter < AbstractAdapter
      
      SERVICE_HOSTS = {
        :international => 'bulksms.vsms.net',
        :safrica       => 'bulksms.2way.co.za',
        :spoin         => 'bulksms.com.es',
        :uk            => 'www.bulksms.co.uk',
        :usa           => 'usa.bulksms.com'
      }
      SERVICE_PORT = 5567
      SERVICE_PATH = '/eapi/submission/send_sms/2/2.0'
      
      STATUS_MESSAGES = {
         0 => 'in progress',
         1 => 'scheduled',
        22 => 'internal fatal error',
        23 => 'authentication failure',
        24 => 'data validation failed',
        25 => 'insufficient credits',
        26 => 'upstream credits not available',
        27 => 'daily quota exceeded',
        28 => 'upstream quota exceeded',
        40 => 'temporarily unavailable'
      }
      
      # Create an adapter for the BulkSMS gateway.
      #
      # Options:
      # * <tt>:region</tt>
      # * <tt>:username</tt>
      # * <tt>:password</tt>
      def initialize(logger = nil, config = {})
        super(logger)
        @config = config.dup
        
        host = SERVICE_HOSTS[config[:region]] || SERVICE_HOSTS[:uk]
        @service_url = "http://#{host}:#{SERVICE_PORT}#{SERVICE_PATH}"
      end
      
      # Return the human readable name of the connection adapter name.
      def adapter_name
        return 'BulkSMS'
      end
      
      def deliver(sms)
        params = {
          :username => @config[:username],
          :password => @config[:password],
          :msisdn   => sms.recipients,
          :message  => sms.body,
        }
        send_http_request(@service_url, params)
      end
      
    end
  end
end
