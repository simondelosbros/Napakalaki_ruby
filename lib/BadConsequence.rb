#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
class BadConsequence
  private_class_method :new # Indica que el método new tiene visibilidad privada
  
  @@MAXTREASURES=10
  
  def initialize(t,l)
    @text=t
    @levels=l
  end
  
  def isEmpty
    raise NotImplementedError.new
  end
  
  def getLevels
    @levels
  end
  
  def BadConsequence.MAXTREASURES
    @@MAXTREASURES
  end
  
  def substractVisibleTreasures(t)
    raise NotImplementedError.new
  end
  
  def substractHiddenTreasures(t)
    raise NotImplementedError.new
  end
  
  def adjustToFitTreasureLists(v,h)
    raise NotImplementedError.new
  end
    
  def aCumplir
    raise NotImplementedError.new
  end
  
  def to_s
    "#{@text}"
  end

end
end
