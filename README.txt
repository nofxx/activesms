== SMS Brasil 

* http://github.com/nofxx/activesms


== DESCRIPTION:

Baseado no ActiveSMS (http://rubyforge.org/projects/activesms) esse projeto visa facilitar o envio de mensagens SMS para operadoras de telefonia celular do Brasil, utilizando serviços de gateway de envio.   


== FEATURES: 

= Gateways:

* BulkSMS[http://www.bulksms.com]
* Clickatell[http://www.clickatell.com]
* Human[http://www.human.com.br] 
* Simplewire[http://www.simplewire.com] (requires jruby)


= Email carriers:

* Brasil, US
* Germany, UK, Austria
* Japan        


== REQUIREMENTS:    
  
* ActionMailer (for email gateways)
  

== INSTALL:

  gem sources -a http://gems.github.com
  sudo gem install nofxx-activesms  

  
== USAGE:

  cd some_rails_app
  script/generate sms Notifier signup:email forgot_password:gateway signoff:human
  
  script/console
  sms = Notifier.create_signup
  Notifer.deliver(sms)


== LICENSE:

(The MIT License)

Copyright (c) 2008 Robert Cottrell (ActiveSms), Brendan G. Lim (SMSFu) (brendangl@gmail.com),
Marcos Piccinini, Cássio Marques (sms_brasil)  