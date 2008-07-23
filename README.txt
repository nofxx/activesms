== SMS Brasil 

* http://github.com/nofxx/brasil_sms

== DESCRIPTION:

Baseado no ActiveSMS (http://rubyforge.org/projects/activesms) esse projeto visa facilitar o envio de mensagens SMS para operadoras de telefonia celular do Brasil, utilizando serviços de gateway de envio.   

== FEATURES: 

= Gateways suportados:

* Human[http://www.human.com.br]
* BulkSMS[http://www.bulksms.com]
* Clickatell[http://www.clickatell.com]
* Simplewire[http://www.simplewire.com] (requires jruby)

= Email carriers:

* Brasil (4)
* US
* Japão        

== REQUIREMENTS:    
  
* ActionMailer (for email gateways)
  
== INSTALL:

  gem sources -a http://gems.github.com
  sudo gem install nofxx-sms_brasil

== LICENSE:

(The MIT License)

Copyright (c) 2008 Robert Cottrell      