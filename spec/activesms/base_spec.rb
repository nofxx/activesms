require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveSms::Base do
  
  it "should be 8" do
    x = ActiveSms::VERSION::STRING
    x.should =~ /0.8/

  end
  
end
