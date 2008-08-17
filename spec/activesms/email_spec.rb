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
  
  
  it "should determine a correct email address" do
    Noter.get_sms_address('5543214321', 'tim').should eql('5543214321@tim.com.br')
      #@email.get_sms_address('5543214321', 'oi').should eql('5543214321@sms.oi.com.br')  
  end
  
  
  
  describe "Instantiated" do
    before(:each) do
      @email = Noter.create_emaio
    end
  
    it "should be valid" do
      violated unless @email
    end
  end 

  

  #   
  #   it "should clean the number" do
  #     @email.get_sms_address('5-543-2=14321', 'tim').should eql('5543214321@tim.com.br')
  #     @email.get_sms_address('55g432g14fd321', 'oi').should eql('5543214321@sms.oi.com.br')  
  #   end
    
  #   it "should throw an error if the carrier is not known" do
  #     lambda {@email.get_sms_address('5543214321', 'nofxx-telecom')}.should raise_error(ActiveSms::CarrierException)
  #   end
  #   
  #   it "should throw an error if the carrier is blank" do
  #     lambda {@email.get_sms_address('5543214321', '')}.should raise_error(ActiveSms::CarrierException)
  #   end
  #   
  #   describe "Email2Sms" do
  #     it "should throw an error if the carrier is blank" do
  #       @sms = ActiveSms::Sms.new
  #       lambda {@email.deliver(@sms)}.should raise_error(ActiveSms::CarrierException)
  #     end
  #   end
  # 

end
