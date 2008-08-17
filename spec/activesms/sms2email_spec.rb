require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sms2Email do
  context 'The SomeMailer mailer' do
    CHARSET = 'utf-8'
    include ActionMailer::Quoting

    setup do
    # You don't need these lines while you are using create_ instead of deliver_
    #ActionMailer::Base.delivery_method = :test
    #ActionMailer::Base.perform_deliveries = true
    #ActionMailer::Base.deliveries = []

      @expected = TMail::Mail.new
      @expected.set_content_type 'text', 'plain', { 'charset' => CHARSET }
      @expected.mime_version = '1.0'
    end

    specify 'should send sms via email' do
      #@expected.subject = 'Account activation'
      @expected.body    = 'hi' #read_fixture('sms_mesage')
      @expected.from    = 'no-email@example.com'
      @expected.to      = 'some@mail.com'

      Sms2Email.create_sms_message("some@mail.com", "hi", "no-email@example.com").\
      encoded.should == @expected.encoded
    end
  end
end
# good post about testing mailers
# => http://kpumuk.info/ruby-on-rails/testing-mailers-with-rspec/