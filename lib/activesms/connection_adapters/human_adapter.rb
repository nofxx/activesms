#require 'net/http'
#require 'uri'
#require 'erb'
require 'activesms/connection_adapters/abstract_adapter'

module ActiveSms
  class Base
    def self.human_sms_connection(config) #:nodoc:
      return ConnectionAdapters::HumanSmsAdapter.new(logger, config)
    end
  end
  
  module ConnectionAdapters
    class HumanSmsAdapter < AbstractAdapter
    
      SERVICE_HOST = "system.human.com.br"
      SERVICE_PATH = "GatewayIntegration/msgSms.do"

# Classe responsavel por realizar o envio das mensagens SMS. 
# O envio eh realizado atraves de uma requisicao HTTP utilizando
# metodo POST.
#class SmsSender
  
  # As configuracoes para envio. Utiliza as mesmas configuracoes
  # para todas as instancias desta classe
  #@@config = nil
  
  #attr_reader :total_sent
    
      def initialize  
        super(logger)
        @config = config.dup
        
         
        human_scheme = config[:use_ssl] ? 'https' : 'http'
        @service_url = "#{human_scheme}://#{SERVICE_HOST}/#{SERVICE_PATH}"
        #raise_not_configured_exception unless @@config && !@@config.empty?
        #@messages = []
        #@results = {}  
        #@total_sent = 0
      end 
      
      # Return the human readable name of the gateway adapter name.
      def adapter_name
        return 'HumanBrasil'
      end   
      
      def deliver(sms)
        params = {                 
          :dispatch => @config[:dispatch],
          :account  => @config[:user],
          :code     => @config[:password],
          :id       => sms.id,
          :to       => sms.recipients,
          :from     => sms.from,#@config[:from]
          :msg      => sms.body,
          :schedule => sms.schedule
        }
        send_http_request(@service_url, params)
      end
    end    
  end
end

  # Define as configuracoes que serao utilizadas para realizar o envio
  # das mensagens.
  # #
  #  # Recebe um hash com os valores a configurar.
  #  def SmsSender.configure(config)        
  #    @@config = config unless !@@config.nil?    
  #  end
  #  
  #  # Exibe as configuracoes de envio atuais
  #  def self.show_configuration
  #    raise_not_configured_exception unless @@config
  #    puts @@config.inspect
  #  end
  #  
  #  # Adiciona um item na lista de mensagens a serem enviadas
  #  def add_message(message)
  #    unless message.kind_of? Sms 
  #      raise ArgumentError, 
  #            "Eu esperava receber um objeto da classe Sms, mas voce me enviou um #{message.class}",
  #            caller
  #    end
  #    @messages << message
  #  end
  #  
  #  # Realiza o envio de todas as mensagens.
  #  # 
  #  # Salva no banco o status de cada SMS
  #  # apos a tentativa de envio.
  #  #
  #  # Retorna um hash com o id e o status de envio
  #  # de cada mensagem.
  #  def send_all    
  #    @messages.each do |m|
  #      resp = run_request(m)
  #      m.status = SmsStatus.find(resp.slice(/\d{3}/))
  #      if block_given?
  #        yield m
  #      end
  #      m.save
  #    end    
  #  end
  #  
  #  # Limpa a lista de mensagens a serem enviadas
  #  def clear_list
  #    @messages.clear    
  #  end
  #  
  #  private   
  #  # Lanca uma excecao indicando que esse sender nao foi devidamente
  #  # configurado antes de ser utilizado.
  #  def self.raise_not_configured_exception # :doc:
  #    raise RuntimeError, "Parametros para configuracao nao informados", caller
  #  end  
  #  
  #  # Cria o header da requisicao (para envio de mensagens individuais)
  #  def create_request_header(message) # :doc:
  #    "dispatch=#{ERB::Util.url_encode(@@config['dispatch'])}"+
  #    "&account=#{ERB::Util.url_encode(@@config['account'])}"+
  #    "&code=#{ERB::Util.url_encode(@@config['password'])}"+
  #    "&msg=#{ERB::Util.url_encode(message.message_text)}"+
  #    "&from=#{ERB::Util.url_encode(@@config['from'])}"+
  #    "&to=#{ERB::Util.url_encode(message.doador.celular.full_number)}"+
  #    "&id=#{ERB::Util.url_encode(message.id)}"+
  #    "&schedule=#{ERB::Util.url_encode(message.agendado_para)}"
  #  end
  #    
  #  # Executa o request HTTP POST para envio da mensagem SMS
  #  def run_request(message) # :doc:    
  #    http = Net::HTTP.new(@@config['base_url'], @@config['port'])
  #    headers = {
  #      'Referer' => 'http://'+@@config['base_url']+@@config['path']      
  #    }    
  #    resp = http.post2(@@config['path'], create_request_header(message), headers)
  #    @total_sent += 1
  #    resp.body    
  #  end
  #              
# end
