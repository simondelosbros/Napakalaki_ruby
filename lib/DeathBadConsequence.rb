#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
class DeathBadConsequence < NumericBadConsequence
  public_class_method :new
  
  def initialize(t)
    super(t,Player.MAXLEVEL,BadConsequence.MAXTREASURES,BadConsequence.MAXTREASURES)
  end
    
  def aCumplir
    "Estas muerto. Descarta todos tus tesoros."
  end
end
end
