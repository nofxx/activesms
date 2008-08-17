require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe ActiveSms::Sms2Email do
  
  before(:each) do
    @sms2email = ActiveSms::Sms2Email.stub!(:new) #Base#.stub!(:new_notifier)
    @sms = ActiveSms::Sms2Email.new
  end
  
  it "should be valid" do
     violated unless @sms
   end
  
  # it "should determine a correct email address" do  
  #    @sms2email.should_receive(:sms_message)
  #  end
  
  it "should determine a correct email address" do  
    @sms.sms_message(:teste).should eql(1)
  end
  
end