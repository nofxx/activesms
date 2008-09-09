Gem::Specification.new do |s|
  s.name = %q{activesms}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Cottrell", "Marcos Piccinini", "Ben Curren", "Dean Mao"]
  s.date = %q{2008-09-09}
  s.description = %q{Active SMS is a framework for sending and receiving SMS messages}
  s.email = ["rgcottrell@rubyforge.org", "x@nofxx.com", "ben@esomnie.com", "dean@esomnie.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt"]
  s.files = [".autotest", "CHANGELOG", "History.txt", "License.txt", "MIT-LICENSE", "Manifest.txt", "README.txt", "Rakefile", "activesms.gemspec", "config/hoe.rb", "config/requirements.rb", "docs/SMS messages and the PDU format.webarchive", "generators/sms/USAGE", "generators/sms/sms_generator.rb", "generators/sms/templates/fixture.rhtml", "generators/sms/templates/model.rb", "generators/sms/templates/sms.yml", "generators/sms/templates/unit_test.rb", "init.rb", "lib/activesms.rb", "lib/activesms/adv_attr_accessor.rb", "lib/activesms/base.rb", "lib/activesms/config.rb", "lib/activesms/connection_adapters/abstract_adapter.rb", "lib/activesms/connection_adapters/bulk_sms_adapter.rb", "lib/activesms/connection_adapters/clickatell_adapter.rb", "lib/activesms/connection_adapters/human_adapter.rb", "lib/activesms/connection_adapters/simplewire_adapter.rb", "lib/activesms/connections.rb", "lib/activesms/email.rb", "lib/activesms/exceptions.rb", "lib/activesms/sms.rb", "lib/activesms/sms2email.rb", "lib/activesms/validations.rb", "lib/activesms/version.rb", "lib/activesms/views/active_sms/sms2_email/sms_message.html.erb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/activesms/base_spec.rb", "spec/activesms/connection_adapters/abstract_adapter_spec.rb", "spec/activesms/connection_adapters/human_adapter_spec.rb", "spec/activesms/connection_adapters/simplewire_spec.rb", "spec/activesms/email_spec.rb", "spec/activesms/sms2email_spec.rb", "spec/activesms/sms_spec.rb", "spec/activesms_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake", "views/active_sms/base/sms2_email/sms_message.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nofxx/activesms}
  s.post_install_message = %q{
For more information on activesms, see http://github.com/nofxx/activesms

}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{activesms}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Active SMS is a framework for sending and receiving SMS messages}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end