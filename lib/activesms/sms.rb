module ActiveSms
  class Sms  
    attr_accessor :delivery, :carrier, :recipients, :from, :body, :id, :schedule
    
    def to_s
      "#<#{self.class.name} @recipients=#{recipients.inspect} @from=#{from.inspect} @body=#{body.inspect} @id=#{id.inspect} @schedule=#{schedule.inspect}>"
    end
  end
end