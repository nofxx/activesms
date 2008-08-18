begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
#$:.unshift(File.dirname(__FILE__) + '/../lib/activesms')
#$:.unshift(File.dirname(__FILE__) + '/../lib/activesms/connection_adapters')
require 'activesms'

include ActiveSms

# #
# HELPERS
#
#
class Object
  
  def attr=(options = {})
    options.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end
end

# ##
#   * http://wincent.com/knowledge-base/Fixtures_considered_harmful%3F
#   * Neil Rahilly
class Hash
  ##
  # Filter keys out of a Hash.
  #
  #   { :a => 1, :b => 2, :c => 3 }.except(:a)
  #   => { :b => 2, :c => 3 }
  def except(*keys)
    self.reject { |k,v| keys.include?(k || k.to_sym) }
  end
  ##
  # Override some keys.
  #
  #   { :a => 1, :b => 2, :c => 3 }.with(:a => 4)
  #   => { :a => 4, :b => 2, :c => 3 }
  def with(overrides = {})
    self.merge overrides
  end
  ##
  # Returns a Hash with only the pairs identified by +keys+.
  #
  #   { :a => 1, :b => 2, :c => 3 }.only(:a)
  #   => { :a => 1 }
  def only(*keys)
    self.reject { |k,v| !keys.include?(k || k.to_sym) }
  end
end