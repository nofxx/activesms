puts "test"

require File.dirname(__FILE__) + "/../test_helper"

# Only run this test if using jruby
if RUBY_PLATFORM =~ /java/
  class SimplewireAdapterTest < Test::Unit::TestCase
    def setup
      @simplewire_adapter = ActiveSms::ConnectionAdapters::SimplewireAdapter.new(nil, { 
        :subscriber_id => 'id', 
        :subscriber_password => 'password'})
    end
    
    def test_instantiation
      assert_raise(RuntimeError) { ActiveSms::ConnectionAdapters::SimplewireAdapter.new(nil, {}) }
      assert @simplewire_adapter
    end
  
    def test_sms_size
      sms = flexmock("sms")
      sms.should_receive(:subscriber_id).and_return("id")
      sms.should_receive(:subscriber_password).and_return("password")
      sms.should_receive(:recipients).and_return("4081234567")
      sms.should_receive(:from).and_return("6502435555")
      long_body = ""
      150.times {long_body += "x"}
      sms.should_receive(:body).and_return(long_body)
      
      assert_raise(StandardError) do 
        s = @simplewire_adapter.create_sms(sms)
      end
    end
      
    def test_parse_sms
      xmldata = create_sms('121212', '6502435555', 'blah blah')
      sms = @simplewire_adapter.parse(xmldata)
      assert_equal 'blah blah', sms.body
      assert_equal '121212', sms.to
      assert_equal '6502435555', sms.from
    end
    
    def test_create_sms
      sms = flexmock("sms")
      sms.should_receive(:subscriber_id).and_return("id")
      sms.should_receive(:subscriber_password).and_return("password")
      sms.should_receive(:recipients).and_return("4081234567")
      sms.should_receive(:from).and_return("6502435555")
      sms.should_receive(:body).and_return("This is the body of the sms")
      
      s = @simplewire_adapter.create_sms(sms)
      
      assert_equal "id", s.subscriber_id
      assert_equal "password", s.subscriber_password
      assert_equal "4081234567", s.destination_addr.address
      assert_equal "6502435555", s.source_addr.address
      assert_equal "This is the body of the sms", s.msg_text
    end
  
  protected
    def create_sms(to, from, body)
      xmldata =<<END
<?xml version="1.0" ?>
        <request version="3.0" protocol="wmp" type="deliver">
        	<account id="123-456-789-12345"/>
        	<destination ton="3" address="#{to}"/>
        	<source carrier="348" ton="1" address="#{from}"/>
        	<option datacoding="7bit" />
        	<message udhi="true" data="0605040B8423F0#{body.unpack('H*')}"/>
        	<ticket id="12004-0923R-1845S-10M25"/>
        </request>
END
      xmldata
    end
  end
end
