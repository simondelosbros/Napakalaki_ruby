#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
class NumericBadConsequence < BadConsequence
  public_class_method :new
  
  def initialize(t,l,v,h)
    super(t,l)
    @nVisibleTreasures=v
    @nHiddenTreasures=h
  end
  
  def isEmpty
    return (@nVisibleTreasures==0 && @nHiddenTreasures==0)
  end
  
  def getNVisibleTreasures
    @nVisibleTreasures
  end
  
  def getNHiddenTreasures
    @nHiddenTreasures
  end
  
  def substractVisibleTreasures(t)
    if @nVisibleTreasures>0
      @nVisibleTreasures-=1
    end
  end
  
  def substractHiddenTreasures(t)
    if @nHiddenTreasures>0
      @nHiddenTreasures-=1
    end
  end
  
  def adjustToFitTreasureLists(v, h)
=begin
    if v.empty? && h.empty?
      adjustBadConsequence=NumericBadConsequence.new(@text, @levels, 0, 0)
      return adjustBadConsequence
    else
      adjustVisible=@nVisibleTreasures, adjustHidden=@nHiddenTreasures
      
      if @nVisibleTreasures>v.length
        adjustVisible=v.length
      end
        
      if @nHiddenTreasures>h.length
        adjustHidden=h.length
      end
        
      adjustBadConsequence=NumericBadConsequence.new(@text, @levels, adjustVisible, adjustHidden)
      return adjustBadConsequence
    end
=end
    adjustVisible = @nVisibleTreasures
    adjustHidden = @nHiddenTreasures
    
    if(v.size < @nVisibleTreasures)
      adjustVisible = v.size
    end
    if(h.size < @nHiddenTreasures)
      adjustHidden = h.size
    end
    
    adjust_bc = NumericBadConsequence.new(@text, @levels, adjustVisible, adjustHidden)
    return adjust_bc
  end
  
  def aCumplir
    "nVisible = #{@nVisibleTreasures}, nHidden = #{@nHiddenTreasures}."
  end
  
end
end
