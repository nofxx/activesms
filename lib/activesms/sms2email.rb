module ActiveSms
  class Base  
    class Sms2Email < ActionMailer::Base


       def sms_message(recipient, message, sender)
         content_type      "text/plain"
         recipients        recipient
         from              sender

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