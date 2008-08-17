module ActiveSms
  class Sms  
    attr_accessor :delivery
    attr_accessor :carrier
    attr_accessor :recipients
    attr_accessor :from
    attr_accessor :body
    attr_accessor :id      
    attr_accessor :schedule
    
    def to_s
      "#<#{self.class.name} @recipients=#{recipients.inspect} @from=#{from.inspect} @body=#{body.inspect} @id=#{id.inspect} @schedule=#{schedule.inspect}>"
    end
  end
end