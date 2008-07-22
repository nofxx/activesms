module ActiveSms
  class Sms
    attr_accessor :recipients
    attr_accessor :from
    attr_accessor :body
    attr_accessor :schedule
#    attr_accessor :id  
    
    def to_s
      "#<#{self.class.name} @recipients=#{recipients.inspect} @from=#{from.inspect} @body=#{body.inspect}>"
    end
  end
end
