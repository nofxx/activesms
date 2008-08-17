module ActiveSms #:nodoc#
    
  class Base
    @@connection = nil
    
    class << self
      # Returns true if a connection that's accessible to this class has already
      # been opened.
      def connected?
        return !@@connection.nil?
      end
          
      # Returns the connection currently associated with the class.  This can
      # also be used to "borrow" the connection to do work that is specific to
      # a particular SMS gateway.
      def connection
        raise ConnectionNotEstablished unless @@connection
        return @@connection
      end
      
      # Set the gateway connection for the class.
      def connection=(spec) #:nodoc:
        raise ConnectionNotEstablished unless spec
        @@connection = spec
      end
    
      # Establishes the connection to the SMS gateway.  Accepts a hash as input
      # where the :adapter key must be specified with the name of a gateway
      # adapter (in lower-case)
      #
      #   ActiveSms::Base.establish_connection(
      #     :adapter  => "clickatell",
      #     :username => "myusername",
      #     :password => "mypassword"
      #     :api_id   => "myapiid"
      #   )
      #
      # Also accepts keys as strings (for parsing from YAML, for example).
      #
      # The exceptions AdapterNotSpecified, AdapterNotFound, and ArgumentError
      # may be returned.
      def establish_connection(config) 
       # config ||= GATEWAY
        config = config.symbolize_keys
        unless config.key?(:adapter)
          raise AdapterNotSpecified, "#{config} adapter is not configured"
        end
        adapter_method = "#{config[:adapter]}_connection"
        unless respond_to?(adapter_method)
          raise AdapterNotFound,
                "configuration specifies nonexistent #{config[:adapter]} adapter"
        end
        self.connection = self.send(adapter_method, config)
      end
    end
    
    # Returns the connection currently associated with the class.  This can
    # also be used to "borrow" the connection to do work that is specific to
    # a particular SMS gateway.
    def connection
      self.class.connection
    end    
  end
end