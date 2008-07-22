module ActiveSms
  class Sms
    attr_accessor :recipients
    attr_accessor :from
    attr_accessor :body
    attr_accessor :id      
    attr_accessor :schedule
    
    def to_s
      "#<#{self.class.name} @recipients=#{recipients.inspect} @from=#{from.inspect} @body=#{body.inspect} @id=#{id.inspect} @schedule=#{schedule.inspect}>"
    end
    
    # Formats the data object to what human gateway expects
    def to_date_format_human      
      self = Time.parse(self, Time.now.utc) unless self.responds_to?('strftime') 
      self.strftime("%d/%m/%Y %H:%M:%S")
    end
  end
end
