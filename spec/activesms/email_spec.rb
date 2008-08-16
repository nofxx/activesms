require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe ActiveSms::Email do
  
  before(:each) do
    #@email = ActiveSms::Base::Notifier.new_mail
  end
  
  
  it "should be valid" do
    violated unless @email
  end
  
  it "should determine a correct email address" do
    @email.get_sms_address('5543214321', 'tim').should eql('5543214321@tim.com.br')
    @email.get_sms_address('5543214321', 'oi').should eql('5543214321@sms.oi.com.br')  
  end
  
  it "should clean the number" do
    @email.get_sms_address('5-543-2=14321', 'tim').should eql('5543214321@tim.com.br')
    @email.get_sms_address('55g432g14fd321', 'oi').should eql('5543214321@sms.oi.com.br')  
  end
  
  it "should throw an error if the carrier is not known" do
      lambda {@email.get_sms_address('5543214321', 'nofxx-telecom')}.should raise_error(ActiveSms::CarrierException)
  end
  
  it "should throw an error if the carrier is blank" do
      lambda {@email.get_sms_address('5543214321', '')}.should raise_error(ActiveSms::CarrierException)
  end
  
  describe "Email2Sms" do
    
    it "should throw an error if the carrier is blank" do
        @sms = ActiveSms::Sms.new
        lambda {@email.deliver(@sms)}.should raise_error(ActiveSms::CarrierException)
    end

  end
end
