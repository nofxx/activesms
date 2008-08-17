#require 'activesms/adv_attr_accessor'
require 'activesms/sms'
require 'activesms/sms2email'
require 'net/https'

module ActiveSms #:nodoc:
  
  # Active SMS allows you to send SMS messages from your application using
  # an SMS model.
  #
  # = SMS models
  #
  # To use Action SMS, you need to create an SMS model.
  #
  #   $ script/generate sms Notifier signup
  #
  # The generated model inherits from ActiveSms::Base.  SMS messages are
  # defined by creating methods on the model which are then used to set
  # variables to be used in the message or to change options on the message.
  #
  # Examples:
  #
  #   class Notifier < ActiveSms::Base
  #     def signup 
  #       delivery   = :gateway
  #       recipients = "447987654321"
  #       from       = "447123456789"
  #       body       = "Your account has been created"
  #     end
  #   end
  #
  # Sender methods have the following configuration methods available.    
  #
  # * <tt>delivery</tt> - Method to use to delivery the SMS.
  #   Accept two paramenters: :gateway or :email
  #
  # * <tt>recipients</tt> - Takes one or more destination numbers.  These
  #   numbers should be formatted in standard international number format.
  #
  # * <tt>from</tt> - Who the SMS message you are sending is from.  This
  #   may be either a number formatted in standard internation number format,
  #   or, if the gateway supports it, an alphanumeric origination.
  #
  # * <tt>body</tt> - The content of the message.  This must fit within the
  #   length limitation of SMS messages.
  #
  # = Sending SMS messages
  #
  # Once an SMS action is defined, you can deliver you message or create it
  # and save it for delivery later.
  #
  #   Notifier.deliver_signup_noification(david) # sends the SMS message
  #
  #   sms = Notifier.create_signup_notification(david) # an SMS object
  #   Notifier.deliver(sms)
  #
  # You never instantiate your model class.  Rather, your delivery instance
  # methods are automatically wrapped in class methods that start with the
  # word <tt>deliver</tt> followed by the name of the SMS method that you
  # would like to deliver.  The <tt>signup_notification</tt> method defined
  # above is delivered by invoking <tt>Notifier.deliver_signup_notification</tt>.
  #
  # = Configuration options
  #
  # These options are specified on the class level.
  #
  # * <tt>logger</tt> - The logger is used for generating information about
  #   the sending run if available.  This can be set to nil for no logging.
  #   It is compatible with Ruby's own Logger and Log4r loggers.
  #
  # * <tt>gateway_settings</tt> - Allows detailed configuration of the SMS
  #   gateway used to deliver the messages.  Some gateways may require
  #   additional configuration settings.
  #
  # * <tt>raise_delivery_errors</tt> - Determines whether or not errors should
  #   be raised if the SMS fails to be delivered.
  #
  # * <tt>delivery_method</tt> - Defines a delivery method.  Possible values
  #   are :gateway (default) or :test.
  #
  # * <tt>perform_deliveries</tt> - Determines whether or not deliver_*
  #   methods are actually carried out.  By default they are, but this can be
  #   turned off to help functional testing.
  #
  # * <tt>deliveries</tt> - Keeps an array of all the messages sent out through
  #   Active SMS with deliver_method :test.  Most useful for unit and functional
  #   testing.
  class Base
    include ActionMailer::AdvAttrAccessor
    include ActionController::UrlWriter
    include Email
    
    @@logger = nil
    cattr_accessor :logger

    private_class_method :new #:nodoc:

    @@raise_delivery_errors = true
    cattr_accessor :raise_delivery_errors
    
    @@delivery_method = :gateway
    cattr_accessor :delivery_method
    
    @@perform_deliveries = true
    cattr_accessor :perform_deliveries
    
    @@deliveries = []
    cattr_accessor :deliveries
     
    # Method to deliver :gateway or :email  
    adv_attr_accessor :delivery  

    # If email we should have a carrier
    adv_attr_accessor :carrier         
    
    # The recipient numbers for the message, either as a string (for a single
    # recipient) or an array (for multiple recipientipients).
    adv_attr_accessor :recipients
    
    # Specify the from number or identifier for the message.
    adv_attr_accessor :from
    
    # Specify the subject of the message.
    adv_attr_accessor :subject
    
    # The content of the message.
    adv_attr_accessor :body     
    
    # The ID of the message.
    adv_attr_accessor :id
    
    # Schedule for delivery
    adv_attr_accessor :schedule
    
    # The Sms message object instance referenced by this model.
    attr_reader :sms
    
    class << self
      def method_missing(method_symbol, *parameters) #:nodoc:
        case method_symbol.id2name
          when /^create_([_a-z]\w+)/ then new($1, *parameters).sms
          when /^deliver_([_a-z]\w+)/ then new($1, *parameters).deliver!
          when "new" then nil
          else super
        end
      end
      
      # Receives an SMS message, parses it into an SMS object, instantiates
      # a new model, and passes the message object to the model object's
      # #receive method.  If you want your model to be able to process
      # incoming messages, you'll need to implement a #receive method
      # that accepts the SMS object as a parameter.
      #
      #   class Notifier < ActionSms::Base
      #     def receive(sms)
      #       ...
      #     end
      #   end
      def receive(sms)
        sms = connection.parse(sms)
        new.receive(sms)
      end
      
      # Deliver the given Sms message object directly.  This can be used to
      # deliver a preconstructed message, like:
      #
      #   sms = Notifier.create_signup_notification(parameters)
      #   Notifier.deliver(sms)
      def deliver(sms)
        new.deliver!(sms)
      end
      
    end
      
    # Instantiate a new Active SMS model object.  If +method_name+ is not
    # +nil+, the model will be initialized according to the named method.
    # If not, the model will remain uninitialized (useful when you need to
    # invoke the "receive" method, for instance).
    def initialize(method_name = nil, *parameters) #:nodoc:
      create!(method_name, *parameters) if method_name
    end
      
    # Initialize the model via the given +method_name+.  The body will be
    # rendered and a new Sms object created.
    def create!(method_name, *parameters) #:nodoc:
      initialize_defaults(method_name)
      send(method_name, *parameters)
      
      # Build the SMS object itself.
      @sms = create_sms
    end
      
    # Delivers an Sms message object.  By default, it deliver the cached object
    # (from the #create! method).  If no cached object exists, and no
    # alternate has been give as the prameter, this will fail.
    # 
    # Mod to enable the user to choose between sending via gateway or email.
    #
    def deliver!(sms = @sms) #:nodoc:
      raise "no SMS object available for delivery!" unless sms
      logger.info "Sending SMS: #{sms} via #{sms.delivery}" unless logger.nil?
      
      begin
        send("perform_delivery_#{sms.delivery}", sms) if perform_deliveries
      rescue Exception => e 
        raise e if raise_delivery_errors
      end
      
      logger.info "SMS Sent!" unless logger.nil?
      return sms
    end
    
    private
    
      # Set up the default values for the various instance variables of this
      # model.  Subclasses may override this method to provide different
      # defaults.
      def initialize_defaults(method_name)
      end
    
      def create_sms
        raise SmsException unless body && recipients
        sms = Sms.new
        sms.delivery = delivery
        sms.recipients = recipients
        sms.from = from
        sms.body = body  
        sms.id = id if id
        sms.carrier = carrier if carrier        
        sms.schedule = schedule if schedule
        @sms = sms
      end
    
      def perform_delivery_gateway(sms)
        raise ConnectionNotEstablished unless connection
        connection.deliver(sms)
      end 
      
      def perform_delivery_email(sms) 
        #raise ConnectionNotEstablished unless email
        email_deliver(sms) 
      end
 
      def perform_delivery_test(sms)
        deliveries << sms
      end

  end
end
