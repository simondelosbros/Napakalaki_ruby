#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame

class Prize
  attr_reader :treasures, :levels
  
  public
  
  def initialize(treasures, levels)
    @treasures=treasures
    @levels=levels
  end
  
=begin
  #EXAMEN
  
  def Prize.newWithoutParameters()
    new(1,1)
  end
  
  #FIN DE EXAMEN

  def treasures
    @treasures
  end
  
  def level
    @level
  end
  
  def to_s
    "Tesoros ganados: #{@treasure} \n Niveles ganados: #{@levels}"
  end
=end
end

end