require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class Noter < ActiveSms::Base
  def emaio 
    @delivery   = :email
    @carrier    = 'tim' #
    @recipients = '5555555555'
    @from       = 'me@somewhere.net'
    @body       = "Hi Friend"
    #@id         = '' 
    #@schedule   = "dd/mm/aaaa hh:mm:ss"
    @options    = {}
  end
end

describe Email do
    
  it "should deliver an sms" do
    sms = mock(Sms, :delivery => :email,  :recipients => '5555555555', :body => 'hi', :options => {},
      :id => 1, :carrier => :tim, :from => 'other@domain.com', :schedule => "08/08/2008 01:18:56")
      Sms2Email.should_receive(:deliver_sms_message).with("5555555555@tim.com.br", "hi", "noreply@domain.com").and_return(true)      
      Noter.deliver(sms)
   end
        
  describe "Include Module" do
    include Email
  
    it "should format number" do
      stub!(:valid?).and_return(false)
      #format_number('555444').should eql('555555555')
    end
        
    it "should determine a correct email address" do
      get_sms_address('5543214321', 'tim').should eql('5543214321@tim.com.br')
    end

    it "should determine two time to be sure" do
      get_sms_address('5543214321', 'oi').should eql('5543214321@sms.oi.com.br')      
    end
        
    it "should be valid with more than 10 digits" do
      is_valid?('1234567890').should be_true
    end
    
    it "should be invalid with lesse than 10 digits" do
      is_valid?('123456789').should_not be_true
    end
        
    it "should be invalid if it has something that is not a number.. NaN hehe" do
      is_valid?('123456789a').should_not be_true
    end
    
    it "should clean the number from evil chars" do
      get_sms_address('5-54g3-2=143h21', 'tim').should eql('5543214321@tim.com.br')     
    end
    
    it "should throw an error if the carrier is not known" do
      lambda {get_sms_address('5543214321', 'nofxx-telecom')}.should raise_error(ActiveSms::CarrierException)
    end
    
    it "should throw an error if the carrier is blank" do
      lambda {get_sms_address('5543214321', '')}.should raise_error(ActiveSms::CarrierException)
    end 
                  
    describe "Email2Sms" do
      it "should throw an error if the carrier is blank" do
        @sms = ActiveSms::Sms.new
        lambda {email_deliver(@sms)}.should raise_error(ActiveSms::CarrierException)
      end
    end
  end 
end
