require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
include ConnectionAdapters

describe HumanAdapter do
  
  before(:each) do 
    @human_adapter = HumanAdapter.new(nil, {:use_ssl => false})
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
    
  it "should parse time nicely" do
    @human_adapter.date_format_human('Fri Aug 08 01:18:56 -0300 2008').should eql("08/08/2008 01:18:56")
  end

  it "should call http to send the message" do
    sms = mock(Sms, :recipients => 'x@xx.com', :body => 'hi', :id => 1,
      :from => 'no@mail.com', :schedule => "08/08/2008 01:18:56")
      
    @human_adapter.should_receive(:send_http_request).\
      with("http://system.human.com.br:8080/GatewayIntegration/msgSms.do", {
        :type=>"E", :from=>"no@mail.com", :msg=>"hi",
        :account=>nil, :dispatch=>"send", :schedule=>"08/08/2008 01:18:56",
        :to=>"x@xx.com", :code=>nil, :id => 1
      }).and_return(true)
    @human_adapter.deliver(sms)#.should be_true    
  end  
end