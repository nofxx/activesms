module ActiveSms #:nodoc#
    
  module Email
    #@@email = nil
    
     
    @config ||= CONFIG
    @@carriers ||= CARRIERS

    def self.carriers
      @@carriers.dup
    end

    def self.deliver_sms(sms)#number,carrier,message,options={})

      number = sms.recipients
      carrier = sms.carrier
      number = format_number(number)
      # raise SMSFuException.new("Cannot deliver an empty message to #{number}") if message.nil? or message.empty?

      #options[:limit] ||= message.length
      #message = message[0..options[:limit]-1]
      sms_email = determine_sms_email(format_number(number),carrier)

      Sms2Email.deliver_sms_message(sms_email,message)
      rescue CarrierException => exception
        raise exception       
    end                                                   
       
    # def get_sms_address(number,carrier)
    #   number = format_number(number)
    #   determine_sms_email(number,carrier)
    # end    

    private

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
      if CARRIERS.has_key?(sms.carrier.downcase)
        "#{phone_number}#{CARRIERS[sms.carrier.downcase]}"
      else 
        raise CarrierException.new("Specified carrier, #{carrier} is not supported.")
      end
    end
     
  end   
     

  class Sms2Mail < ActionMailer::Base
     
    @@from_address = CONFIG['from_address']
    cattr_accessor :from_address 
     
     
    def sms_message(recipient, message)
      content_type      "text/plain"
      recipients        recipient
      from              from_address

      body['message'] = message
    end

    view_path = File.join(File.dirname(__FILE__), '..', 'views')
    if public_methods.include?('append_view_path')
      self.append_view_path view_path
    elsif public_methods.include?("view_paths")
      self.view_paths << view_path
    else
      self.template_root = view_path
    end   
                                           
  end    
end


# require 'yaml'
# require 'sms_notifier'
# # Copyright (c) 2008 Brendan G. Lim (brendangl@gmail.com)
# # 
# # Permission is hereby granted, free of charge, to any person obtaining
# # a copy of this software and associated documentation files (the
# # "Software"), to deal in the Software without restriction, including
# # without limitation the rights to use, copy, modify, merge, publish,
# # distribute, sublicense, and/or sell copies of the Software, and to
# # permit persons to whom the Software is furnished to do so, subject to
# # the following conditions:
# # 
# # The above copyright notice and this permission notice shall be
# # included in all copies or substantial portions of the Software.
# # 
# # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# # LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# # OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# # WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
# require 'yaml'
# # Copyright (c) 2008 Brendan G. Lim (brendangl@gmail.com)
# # 
# # Permission is hereby granted, free of charge, to any person obtaining
# # a copy of this software and associated documentation files (the
# # "Software"), to deal in the Software without restriction, including
# # without limitation the rights to use, copy, modify, merge, publish,
# # distribute, sublicense, and/or sell copies of the Software, and to
# # permit persons to whom the Software is furnished to do so, subject to
# # the following conditions:
# # 
# # The above copyright notice and this permission notice shall be
# # included in all copies or substantial portions of the Software.
# # 
# # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# # EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# # MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# # NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# # LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# # OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# # WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
# class SmsNotifier < ActionMailer::Base
#   @config = YAML::load(File.open("#{RAILS_ROOT}/config/sms_fu.yml"))
#   @@from_address = @config['config']['from_address']
#   cattr_accessor :from_address
# 
#   def sms_message(recipient, message)
#     content_type      "text/plain"
#     recipients        recipient
#     from              from_address
#     
#     body['message'] = message
#   end
# 
#   view_path = File.join(File.dirname(__FILE__), '..', 'views')
#   if public_methods.include?('append_view_path')
#     self.append_view_path view_path
#   elsif public_methods.include?("view_paths")
#     self.view_paths << view_path
#   else
#     self.template_root = view_path
#   end
#   
# end   