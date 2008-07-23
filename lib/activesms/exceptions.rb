module ActiveSms #:nodoc:

  # Generic error class and superclass of all other errors raised by
  # Active SMS
  class ActiveSmsError < StandardError
  end
  
  # The configuration hash used in <tt>establish_connection</tt> didn't include
  # <tt>:adapter</tt> key
  class AdapterNotSpecified < ActiveSmsError
  end
  
  # The <tt>adapter</tt> key used in <tt>establish_connection</tt> specified a
  # nonexistent adapter.
  class AdapterNotFound < ActiveSmsError
  end
  
  # No connection has been established.  Use <tt>establish_connection</tt>
  # before sending a message.
  class ConnectionNotEstablished < ActiveSmsError
  end     
  
  # Problems with email carriers
  class CarrierException < ActiveSmsError
  end
  
end
