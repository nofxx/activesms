require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'net/https'

include ConnectionAdapters

describe AbstractAdapter do
  
  before(:each) do 
    @abstract_adapter = AbstractAdapter.new(nil)
  end
    
  it "should instantiate" do
    violated unless @abstract_adapter
  end
  
  it "should have a name" do
    @abstract_adapter.adapter_name.should eql("Abstract")
  end
  
  it "should have a default deliver method, to be implemented by subclasses" do
    @abstract_adapter.should_receive(:deliver)
    @abstract_adapter.deliver(mock(Sms))
  end
  
  it "should respond to parse with nil.. for some obscure reason" do
    @abstract_adapter.parse(mock(Sms)).should eql(nil)
  end  
  
  
end