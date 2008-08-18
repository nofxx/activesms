require 'yaml'
#require 'activesms/config'

module ActiveSms #:nodoc#   
  module Email
    RAILS_CONFIG_ROOT = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/config" : "#{File.dirname(__FILE__)}/../../generators/sms/templates" unless defined?(RAILS_CONFIG_ROOT)
    # and load what we have!
    conf_yml ||= YAML::load(File.open("#{RAILS_CONFIG_ROOT}/sms.yml"))
    @@carriers ||= conf_yml['carriers']
    @@from_address ||= conf_yml['config']['from_address']

    def carriers
      @@carriers.dup
    end
    
    def email_deliver(sms)#number,carrier,message,options={})

      number = sms.recipients
      carrier = sms.carrier
      # number = format_number(number)

      #options[:limit] ||= message.length 
        #options[:from]  ||= @@from_address
      #message = message[0..options[:limit]-1]
      sms_email = determine_sms_email(number, carrier)#format_number(number),carrier)
       
      Sms2Email.deliver_sms_message(sms_email, sms.body, @@from_address)
    rescue CarrierException => e
      raise e
    end                                                   
     
    def get_sms_address(number,carrier)
      number = format_number(number)
      determine_sms_email(number,carrier)
    end    

    private

    def format_number(number)
      pre_formatted = number.gsub(/\D/,"").strip
      formatted =  (pre_formatted.length > 11) ? pre_formatted[2..pre_formatted.length] : pre_formatted
       
      return is_valid?(formatted) ? formatted : (raise PhoneNumberError.new("Phone number (#{format_number(number)}) is not formatted correctly"))
    end   
    
    def is_valid?(number)
      return (number.length >= 10 && number[/^.\d+$/]) ? true : false
    end  
       
    def determine_sms_email(phone_number, carrier)
      carrier = carrier.to_s.downcase     

      if carriers.has_key?(carrier)
        "#{phone_number}#{carriers[carrier]}"
      else 
        raise CarrierException.new("Specified carrier, #{carrier} is not supported.")
      end
    end     
  end   
end