# Representa um numero de celular
class Celular
    
  attr_reader :number, :original_number, :area_code 
    
  # Cria um novo numero de celular
  def initialize(n)    
    n =~ /(\(?(\d{2})\)?\s?)?([89]\d{3}[-\s]?\d{4})/       
    @area_code = $2    
    @original_number = n
    @number = $3
    @number = $3.sub(/[\s-]+/, '') unless @number.nil?  
  end

  
  # Retorna o numero de celular no formato
  #   <codigo do pais><codigo de area><numero>
  # Por exemplo: 551287899876
  def full_number
    "55#{area_code}#{@number}"    
  end
  
  # Verifica se este numero de celular possui prefixo
  def has_prefix?
    !@area_code.nil? && !@area_code.empty? 
  end
  
  # Verifica se o numero de celular eh valido, ou seja
  # se eh composto por oito digitos, separados ou nao por
  # espaco em branco ou hifem e se comeca por 8 ou 9.
  def valid_number?    
    @number =~ /[89]\d{3}[-\s]?\d{4}/    
  end
  
end
