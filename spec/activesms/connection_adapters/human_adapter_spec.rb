require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ActiveSms::ConnectionAdapters::HumanAdapter do
  
  before(:each) do 
    @human_adapter = ActiveSms::ConnectionAdapters::HumanAdapter.new(nil, {:use_ssl => false})
  end
    
  it "should instantiate" do
    violated unless @human_adapter
  end
  
  it "should have a name" do
    @human_adapter.adapter_name.should eql("Human")
  end
  
  it "should have a good url to send" do
    @human_adapter.service_url.should eql("http://system.human.com.br:8080/GatewayIntegration/msgSms.do")
  end
    
  it "should have a nice time parser" do
    @human_adapter.date_format_human('Fri Aug 08 01:18:56 -0300 2008').should eql("08/08/2008 01:18:56")
  end


  
end