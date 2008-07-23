require 'activesms/sms2email'  

module ActiveSms #:nodoc#
    
  class Base
    #@@email = nil
    @config ||= CONFIG
    @@carriers ||= CARRIERS
            
    #class << self
      def carriers
        @@carriers.dup
      end

      def deliver_sms(sms)#number,carrier,message,options={})

        number = sms.recipients
        carrier = sms.carrier
  #      number = Email::format_number(number)
        # raise SMSFuException.new("Cannot deliver an empty message to #{number}") if message.nil? or message.empty?

        #options[:limit] ||= message.length
        #message = message[0..options[:limit]-1]
        sms_email = determine_sms_email(number, carrier)#format_number(number),carrier)

        Sms2Email.deliver_sms_message(sms_email, sms.body)
        rescue CarrierException => exception
          raise exception       
      end                                                   
       
      def get_sms_address(number,carrier)
        number = format_number(number)
        determine_sms_email(number,carrier)
      end    

      #private

      def format_number(number)
        pre_formatted = number.gsub("-","").strip
        formatted =  (pre_formatted.length == 11 && pre_formatted[0,1] == "1") ? pre_formatted[1..pre_formatted.length] : pre_formatted
         
        #return is_valid?(formatted) ? formatted : (raise SMSFuException.new("Phone number (#{number}) is not formatted correctly"))
      end   
      # 
      # def is_valid?(number)
      #   return (number.length >= 10 && number[/^.\d+$/]) ? true : false
      # end  
         
      def determine_sms_email(phone_number, carrier)
        carrier = carrier.downcase     
        
        #unless config.key?(:adapter)
        if carriers.has_key?(carrier)
          "#{phone_number}#{carriers[carrier]}"
        else 
          raise CarrierException.new("Specified carrier, #{carrier} is not supported.")
        end
      end  
     #   end
  end   
     

  
end


# require 'yaml'
# require 'sms_notifier'


# 
# module SMSFu
#   RAILS_CONFIG_ROOT = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/config" : "#{File.dirname(__FILE__)}/../templates" unless defined?(RAILS_CONFIG_ROOT)
#   @config ||= YAML::load(File.open("#{RAILS_CONFIG_ROOT}/sms_fu.yml"))
#   @@carriers ||= @config['carriers']
#   
#   def self.carriers
#     @@carriers.dup
#   end
#   
#   def deliver_sms(number,carrier,message,options={})
#     number = format_number(number)
#     raise SMSFuException.new("Cannot deliver an empty message to #{number}") if message.nil? or message.empty?
#     
#     options[:limit] ||= message.length
#     message = message[0..options[:limit]-1]
#     sms_email = determine_sms_email(format_number(number),carrier)
#     
#     SmsNotifier.deliver_sms_message(sms_email,message)
#   rescue SMSFuException => exception
#     raise exception
#   end
#   
#   def get_sms_address(number,carrier)
#     number = format_number(number)
#     determine_sms_email(number,carrier)
#   end
#   
#   private
#   
#   def format_number(number)
#     pre_formatted = number.gsub("-","").strip
#     formatted =  (pre_formatted.length == 11 && pre_formatted[0,1] == "1") ? pre_formatted[1..pre_formatted.length] : pre_formatted
# 
#     return is_valid?(formatted) ? formatted : (raise SMSFuException.new("Phone number (#{number}) is not formatted correctly"))
#   end
#   
#   def is_valid?(number)
#     return (number.length >= 10 && number[/^.\d+$/]) ? true : false
#   end  
#   
#   def determine_sms_email(phone_number, carrier)
#     if @@carriers.has_key?(carrier.downcase)
#       "#{phone_number}#{@@carriers[carrier.downcase]}"
#     else 
#       raise SMSFuException.new("Specified carrier, #{carrier} is not supported.")
#     end
#   end 
#        
#   class SMSFuException < StandardError; end
# end   
# 
