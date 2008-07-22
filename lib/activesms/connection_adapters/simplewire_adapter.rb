require 'activesms/connection_adapters/abstract_adapter'
require 'ostruct'

begin
  require 'java'
  include_class 'com.simplewire.sms.SMS'
rescue LoadError
  puts "JRuby is required for the simplewire adapter"
  raise $!
end

module ActiveSms
  class Base
    def self.simplewire_connection(config) #:nodoc:
      return ConnectionAdapters::SimplewireAdapter.new(logger, config)
    end
  end
  
  module ConnectionAdapters
    class SimplewireAdapter < AbstractAdapter

      # Create a simplewire adapter. The config requires subscriber_id and subscriber_password.
      def initialize(logger = nil, config = {})
        super(logger)
        @config = config.dup
        @config.symbolize_keys!
        @subscriber_id = @config[:subscriber_id]
        @subscriber_password = @config[:subscriber_password]
        @remote_host = @config[:remote_host]
         
        if @subscriber_id.nil?
          raise "subscriber_id is required for simplewire"
        end
        if @subscriber_password.nil?
          raise "subscriber_password is required for simplewire"
        end
      end
      
      # Return the human readable name of the gateway adapter name.
      def adapter_name
        return 'Simplewire'
      end
      
      # Send the sms message using the simplewire adapter
      def deliver(sms)
        create_sms(sms).submit()
      end
      
      def parse(xmldata)        
        sms = SMS.new
        sms.parse(xmldata)
        s = OpenStruct.new
        s.body = sms.msg_text.to_s
        s.from = sms.source_addr.address.to_s
        s.to = sms.destination_addr.address.to_s
        s
      end
      
      # Create the simplewire sms message to send
      def create_sms(sms) 
        s = SMS.new
        s.subscriber_id = @subscriber_id
        s.subscriber_password = @subscriber_password
        s.remote_host = @remote_host if @remote_host
        s.msg_pin = sms.recipients
        s.setSourceAddr(SMS::ADDR_TYPE_NETWORK, sms.from)
        s.msg_text = sms.body
        raise StandardError.new("SMS Body over 140 characters, body = \n#{sms.body}") if sms.body.size > 140
        s
      end
    end
  end
end
