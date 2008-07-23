Gem::Specification.new do |s|
  s.name = %q{activesms}
  s.version = "0.8.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robert Cottrell", "Ben Curren", "Dean Mao"]
  s.cert_chain = ["/Users/nofxx/.gem/gem-public_cert.pem"]
  s.date = %q{2008-07-23}
  s.description = %q{Active SMS is a framework for sending and receiving SMS messages}
  s.email = ["rgcottrell@rubyforge.org", "ben@esomnie.com", "dean@esomnie.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = ["CHANGELOG", "History.txt", "License.txt", "MIT-LICENSE", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "generators/sms/USAGE", "generators/sms/sms_generator.rb", "generators/sms/templates/fixture.rhtml", "generators/sms/templates/model.rb", "generators/sms/templates/smsconfig.yml", "generators/sms/templates/unit_test.rb", "init.rb", "lib/activesms.rb", "lib/activesms/adv_attr_accessor.rb", "lib/activesms/base.rb", "lib/activesms/config.rb", "lib/activesms/connection_adapters/abstract_adapter.rb", "lib/activesms/connection_adapters/bulk_sms_adapter.rb", "lib/activesms/connection_adapters/clickatell_adapter.rb", "lib/activesms/connection_adapters/human_adapter.rb", "lib/activesms/connection_adapters/simplewire_adapter.rb", "lib/activesms/connections.rb", "lib/activesms/email.rb", "lib/activesms/exceptions.rb", "lib/activesms/sms.rb", "lib/activesms/validations.rb", "lib/activesms/version.rb", "scripts/console", "scripts/destroy", "scripts/generate", "scripts/txt2html", "setup.rb", "sms_brasil.gemspec", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "test/connection_adapters/test_simplewire_adapter.rb", "test/test_activesms.rb", "test/test_helper.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb", "website/template.rhtml"]
  s.has_rdoc = true
  s.homepage = %q{http://activesms.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{activesms}
  s.rubygems_version = %q{1.2.0}
  s.signing_key = %q{/Users/nofxx/.gem/gem-private_key.pem}
  s.summary = %q{Active SMS is a framework for sending and receiving SMS messages}
  s.test_files = ["test/connection_adapters/test_simplewire_adapter.rb", "test/test_activesms.rb", "test/test_helper.rb"]

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
