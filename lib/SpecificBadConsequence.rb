#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame
class SpecificBadConsequence < BadConsequence
  public_class_method :new
  
  def initialize(t,l,v,h)
    super(t,l)
    @specificVisibleTreasures=v
    @specificHiddenTreasures=h
  end
  
  def isEmpty
    return (@specificHiddenTreasures.empty? && @specificVisibleTreasures.empty?)
  end
  
  def getSpecificVisibleTreasures
    @specificVisibleTreasures
  end
  
  def getSpecificHiddenTreasures
    @specificHiddenTreasures
  end
  
  def substractVisibleTreasures
    if !@specificVisibleTreasures.empty?
      i=0
      while(@specificVisibleTreasures.at(i)!=t.getType)
        i+=1
      end
      @specificVisibleTreasures.delete_at(i)
    end
  end
 
  def substractHiddenTreasures
    if !@specificHiddenTreasures.empty?
      i=0
      while(@specificHiddenTreasures.at(i)!=t.getType)
        i+=1
      end
      @specificHiddenTreasures.delete_at(i)
    end
  end
  
  def adjustToFitTreasureLists(v, h)
    if v.empty? && h.empty?
      adjustBadConsequence=SpecificBadConsequence.new(@text,@levels,Array.new, Array.new)
      return adjustBadConsequence
    else
      adjustspecificV=Array.new
      adjustspecificH=Array.new
      
      v.each { |x|
        @specificVisibleTreasures.each { |y|
          if(x.getType==y)
            adjustspecificV<<y
          end
        }
      }
      
      h.each { |x|
        @specificHiddenTreasures.each { |y|
          if(x.getType==y)
            adjustspecificH<<y
          end
        }
      }
      adjustBadConsequence=SpecificBadConsequence.new(@text, @levels, adjustspecificV, adjustspecificH)
      return adjustBadConsequence;
    end
  end
  
  def aCumplir
    "SpecificVisible = #{@specificVisibleTreasures}, specificHidden = #{@specificHiddenTreasures}."
  end
  
end
end
