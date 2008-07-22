require 'net/https'

module ActiveSms #:nodoc:
  module ConnectionAdapters #:nodoc:
    # All the concrete gateway adapters follow the interface laid down in this
    # class.  You can use this interface directly by borrowing the gateway
    # connection from the Base with Base.connection.
    class AbstractAdapter
      
      @logger = nil
      attr_accessor :logger
      
      def initialize(logger = nil) #:nodoc:
        @logger = logger
      end
      
      # Return the human readable name of the gateway adapter.
      def adapter_name
        return 'Abstract'
      end
      
      def deliver(sms)
      end
      
      def parse(sms)
        nil
      end
      
      protected
      
      # Helper method to send an HTTP request to +url+ with paramaters
      # specified by the +params+ hash.
      def send_http_request(url, params)
        uri = URI.parse(url)
        req = Net::HTTP::Post.new(uri.path)
        req.set_form_data(params)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'
        resp = http.start do
          http.request(req)
        end
        @logger.info "Response: #{resp.body}" unless @logger.nil?
        
        return resp.body
      rescue Exception => e
        raise e
      end
      
    end
  end
end
