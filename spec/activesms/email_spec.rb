require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


class Noter < ActiveSms::Base

  def emaio 
    @delivery   = :email
    @carrier    = 'tim' #
    @recipients = '553555555'
    @from       = ''
    @body       = "Nodsdsdsdster#emaio"
    @options    = {}
  end

  def gatuei
    @delivery   = :gateway
    @recipients = '555555555'
    @from       = ''
    @body       = "ALOU ALOU"
    @options    = {}
  end
end

describe Email do
  
  before(:each) do
   @base = mock(Noter)
   @email = ActiveSms::Base.new('noter')
   #Sms.new#.create_emaio#ActiveSms::Base#.stub!(:new_notifier)
  end
  
  
  it "should deliver an sms" do
    sms = mock(Sms, :recipients => 'x@xx.com', :body => 'hi', :id => 1,
      :from => 'no@mail.com', :schedule => "08/08/2008 01:18:56")
      Sms2Email.should_receive(:deliver_sms_message).with("some@mail.com", "hi", "Mr X").and_return(true)
      @email.email_deliver(sms)
   end
   
  # it "should be valid" do
  #     violated unless @email
  #   end
  #  
  #  # it "should determine a correct email address" do
  #    #  ActiveSms::Base.should_receive(:get_sms_address)
  #     #@email.get_sms_address('5543214321', 'tim').should eql('5543214321@tim.com.br')
  #    # @email.get_sms_address('5543214321', 'oi').should eql('5543214321@sms.oi.com.br')  
  #   end
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
