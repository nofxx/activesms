#
# Copyright (c) 2008 Robert Cottrell, Brendan G. Lim (brendangl@gmail.com),
#                    Marcos Piccinini, Cássio Marques
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

# Require ActiveSupport for standard Rails extensions.
unless defined?(ActiveSupport)
  begin
    require 'active_support'
  rescue LoadError
    require 'rubygems'
    require 'activesupport'
  end
end

# Require ActionController for access to UrlWriter in ActiveSms::Base senders.
unless defined?(ActionController)
  begin
    require 'action_controller'
  rescue LoadError
    require 'rubygems'
    require 'actionpack', '>= 1.12.5'
  end
end    

# Require ActionMailer to perform mail gateway deliveries
unless defined?(ActionMailer)
  begin
    require 'action_mailer'
  rescue LoadError
    require 'rubygems'
    require 'actionmailer', '>= 1.12.5'
  end
end

# Require global config
require 'activesms/config'
# These ppl need global config:
require 'activesms/email'

# Require base classes.
require 'activesms/version'
require 'activesms/base'
require 'activesms/connections' 
require 'activesms/exceptions'
require 'activesms/version'

# Require the supported gateways connection adapters.
require 'activesms/connection_adapters/abstract_adapter'
require 'activesms/connection_adapters/bulk_sms_adapter'
require 'activesms/connection_adapters/clickatell_adapter'
require 'activesms/connection_adapters/human_adapter'
                         

# Simplewire requires jruby
if RUBY_PLATFORM =~ /java/
  require 'activesms/connection_adapters/simplewire_adapter'
end
