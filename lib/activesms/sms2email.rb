module ActiveSms
  class Base  
    class Sms2Email < ActionMailer::Base

       @@from_address = CONFIG['from_address']
       cattr_accessor :from_address 


       def sms_message(recipient, message)
         content_type      "text/plain"
         recipients        recipient
         from              from_address

         body['message'] = message
       end

       view_path = File.join(File.dirname(__FILE__), '..', '..', 'views')
       if public_methods.include?('append_view_path')
         self.append_view_path view_path
       elsif public_methods.include?("view_paths")
         self.view_paths << view_path
       else
         self.template_root = view_path
       end   

     end  
   end
end


# require 'yaml'

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