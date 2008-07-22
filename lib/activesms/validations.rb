module ActiveSms
  # The SMS message object is invalid.  Use the sms method to retrieve the
  # message which did not validate.
  class SmsInvalid < ActiveSmsError
    attr_reader :sms
    def initialize(sms)
      @sms = sms
      super("Validation failed: #{@sms.errors.full_messages.join(', ')}")
    end
  end
  
  # Active SMS validation is reported to and from this object, which is used
  # by Base to determine whether the message is in a valid state to be sent.
  class Errors
    include Enumerable
    
    # Holds a hash with all the default error message.  This can be replaced
    # by your own copy or localizations.
    @@default_error_messages = {
      :invalid => "is invalid"
    }
    cattr_accessor :default_error_messages
    
    def initialize(base) #:nodoc:
      @base = base
      @errors = {}
    end
    
    # Adds an error message to the base object instead of any particular
    # attribute for the object.  This is used to report errors that don't
    # tie to any specific attribute, but to the object as a whole.  These
    # error messages don't get prepended with any field name when iterating
    # with each_full, so they should be complete sentences.
    def add_to_base(msg)
      add(:base, msg)
    end
    
    # Adds an error message +msg+ to the +attribute+, which will be returned
    # on a call to <tt>on(attribute)</tt> for the same attribute and ensure
    # that this error object returns false when asked if <tt>empty?</tt>.
    # More than one error can be added to the same +attribute+, in which
    # case an array will be returned on a call to <tt>on(attribute)</tt>.
    # If no +msg+ is supplied, "invalid" is assumed.
    def add(attribute, msg = @@default_error_messages[:invalid])
      @errors[attribute.to_s] ||= []
      @errors[attribute.to_s] << msg
    end
  end
end
