require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module SmsSpecHelper
  def attr_valid_sms
    {
      :delivery   => :email,
      :carrier    => 'tim',
      :recipients => '5544443333',
      :from       => 'someone@somewher.net',
      :body       => 'hello...how are your family?',
      :id         => 1,
      :schedule   => Time.parse('Sat Aug 09 03:44:19 -0300 2008')
    }
  end
end
describe Sms do
  include SmsSpecHelper

  before(:each) do 
    @sms = Sms.new
  end
    
  it "should be a valid sms" do
    violated unless @sms
  end

  it "should return a nice string" do
    @sms.attr = attr_valid_sms
    @sms.to_s.should eql("#<ActiveSms::Sms @recipients=\"5544443333\" @from=\"someone@somewher.net\" @body=\"hello...how are your family?\" @id=1 @schedule=Sat Aug 09 03:44:19 -0300 2008>")
  end
end