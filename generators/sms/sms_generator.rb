class SmsGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name, "#{class_name}Test"
      
      # Create model, view, test, and fixture directories.
      m.directory File.join('app/models', class_path)    
      m.directory File.join('test/unit', class_path)
      m.directory File.join('test/fixtures', file_path)
      
      # Create model class and unit test. 
      # TODO: ugly hack in model.rb to make delivery only :gateway
      # fix when we got multiple gw connections
      m.template "model.rb", File.join('app/models',
                                       class_path,
                                       "#{file_name}.rb")
      m.template "unit_test.rb", File.join('test/unit',
                                            class_path,
                                            "#{file_name}_test.rb") 
      m.template "sms.yml", File.join('config',
                                            class_path,
                                            "sms.yml")                                   
      # Create fixture for each action.
      actions.each do |action|
        relative_path = File.join(file_path, action.split(':')[0])
        fixture_path  = File.join('test/fixtures', relative_path)
        
        m.template "fixture.rhtml", fixture_path,
                   :assigns => { :action => action, :path => fixture_path }
      end 
    end
  end

end
