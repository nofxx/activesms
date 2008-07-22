require File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../test_helper'

class <%= class_name %>Test < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../fixtures'
  
  def setup
    ActiveSms::Base.delivery_method = :test
    ActiveSms::Base.perform_deliveries = true
    ActiveSms::Base.deliveries = []
    
    @expected = ActiveSms::Sms.new
  end
  
<% actions.each do |action| -%>
  def test_<%= action %>
    @expected.recipients = ''
    @expected.from = ''
    @expected.body = read_fixture('<%= action %>')
    
    actual = <%= class_name %>.create_<%= action %>
    assert_equal @expected.recipients, actual.recipients
    assert_equal @expected.from, actual.from
    assert_equal @expected.body, actual.body
  end
  
<% end -%>
  private
  def read_fixture(action)
    IO.read("#{FIXTURES_PATH}/<%= file_path %>/#{action}")
  end
end