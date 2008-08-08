require 'activesms/sms2email'  

module ActiveSms #:nodoc#   
  class Base
    module Email
    @config ||= CONFIG
    @@carriers ||= CARRIERS
    @@from_address ||= CONFIG['from_address']

    def carriers
      @@carriers.dup
    end
    

    def email_deliver(sms)#number,carrier,message,options={})

      number = sms.recipients
      carrier = sms.carrier
      # number = format_number(number)

      #options[:limit] ||= message.length
      options[:from]  ||= @@from_address
      #message = message[0..options[:limit]-1]
      sms_email = determine_sms_email(number, carrier)#format_number(number),carrier)
       
      Sms2Email.deliver_sms_message(sms_email, sms.body, options[:from])
      rescue CarrierException => exception
        raise exception       
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
      carrier = carrier.downcase     

      if carriers.has_key?(carrier)
        "#{phone_number}#{carriers[carrier]}"
      else 
        raise CarrierException.new("Specified carrier, #{carrier} is not supported.")
      end
    end     
  end
  end   
end