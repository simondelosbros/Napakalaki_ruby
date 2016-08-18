#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'Dice.rb'
require_relative 'CombatResult.rb'
require_relative 'Treasure.rb'
require_relative 'BadConsequence.rb'
require_relative 'TreasureKind.rb'
require_relative 'NumericBadConsequence.rb'
require_relative 'SpecificBadConsequence.rb'
require_relative 'DeathBadConsequence.rb'

module NapakalakiGame

class Player
  @@MAXLEVEL=10
  #no se si poner dead en el attr_reader o en @dead para inicializarlo a true
  attr_reader :name, :level, :hiddenTreasures, :visibleTreasures, :dead, :pendingBadConsequence
  
  public
  def initialize(name)
    @name=name
    @pendingBadConsequence=NumericBadConsequence.new("Inicializacion",0,0,0)
    @level=1
    @hiddenTreasures=Array.new
    @visibleTreasures=Array.new
    @dead=true
  end
  
  def copy_constructor(p)
    @level=p.level
    @hiddenTreasures=p.hiddenTreasures
    @visibleTreasures=p.visibleTreasures
    @dead=p.dead
    @pendingBadConsequence=p.pendingBadConsequence
  end
  
  #EXAMEN
  def setVisibleTreasures(tesoros)
    @visibleTreasures=tesoros
  end
  
  def setHiddenTreasures(tesoros)
    @hiddenTreasures=tesoros
  end
  #FINEXAMEN
  
  #No se me ocurre otra manera de devolver @@MAXLEVEL
  def self.MAXLEVEL
    @@MAXLEVEL
  end
  
  protected
  def getCombatLevel
    bonus_visible=0
    
    @visibleTreasures.each { |x|
      bonus_visible+=x.bonus
    }
    
    return bonus_visible+@level 
  end
  
  def shouldConvert
    number=Dice.instance.nextNumber
    return number==6
  end
  
  def getOponentLevel(m)
    return m.getCombatLevel
  end
  
  private
  def bringToLife
    @dead=false
  end
  
  def incrementLevels(i)
    if i>=1
      @level+=i
    end
  end
  
  def decrementLevels(i)
    if i<@level
      @level-=i;
    else
      @level=1;
    end
  end

  def setPendingBadConsequence(b)
    @pendingBadConsequence=b
  end
  
  def applyPrize(m)
    nLevels=m.getLevelsGained
    incrementLevels(nLevels)
    nTreasures=m.getTreasuresGained
        
    if nTreasures>0
      dealer=CardDealer.instance
      for i in 0..nTreasures
        treasure=dealer.nextTreasure
        @hiddenTreasures<<treasure
      end
    end
  end
  
  def applyBadConsequence(m)
    badConsequence=m.getBadConsequence
    nLevels=badConsequence.getLevels
    decrementLevels(nLevels);
    @pendingBadConsequence=badConsequence.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
    setPendingBadConsequence(@pendingBadConsequence)
  end
  
  def canMakeTreasureVisible(t)
    manos_ocupadas=0
    
    @visibleTreasures.each { |x|
      if x.getType==NapakalakiGame::TreasureKind::ONEHAND
        manos_ocupadas+=1
      end
      
      if x.getType==t.getType && t.getType!=NapakalakiGame::TreasureKind::ONEHAND
        return false
      else
        if t.getType==NapakalakiGame::TreasureKind::BOTHHANDS
          if x.getType==NapakalakiGame::TreasureKind::ONEHAND
            return false
          end
        else
          if t.getType==NapakalakiGame::TreasureKind::ONEHAND
            if x.getType==NapakalakiGame::TreasureKind::BOTHHANDS || manos_ocupadas==2
              return false
            end
          end
        end
      end
    }
    
    return true
  end
  
  def howManyVisibleTreasures(tKind)
    n_treasures=0
    @visibleTreasures.each { |x|
      if(x.type==tKind)
        n_treasures+=1
      end
    }
    return n_treasures
  end
  
  def dieIfNoTreasures
    if(@hiddenTreasures.empty? && @visibleTreasures.empty?)
      @dead=true
    end
  end
  
  public
  def isDead
    @dead
  end
 
  def getName
    @name
  end
  
  def getHiddenTreasures
    @hiddenTreasures
  end
  
  def getVisibleTreasures
    @visibleTreasures
  end
  
  def combat(m)
    combatResult=CombatResult
    
    myLevel=getCombatLevel
    monsterLevel=getOponentLevel(m)
    
    if myLevel>monsterLevel
      applyPrize(m)
      if @level>=@@MAXLEVEL
        combatResult=NapakalakiGame::CombatResult::WINGAME
      else
        combatResult=NapakalakiGame::CombatResult::WIN
      end
    else
      if shouldConvert
        combatResult=NapakalakiGame::CombatResult::LOSEANDCONVERT
      else
        combatResult=NapakalakiGame::CombatResult::LOSE
      end
      applyBadConsequence(m)
    end
    
    return combatResult
  end
  
  def makeTreasureVisible(t)
    canl=canMakeTreasureVisible(t)
        
    if canl
      @visibleTreasures << t
      @hiddenTreasures.delete(t)
    end
  end
  
  def discardVisibleTreasure(t)
    @visibleTreasures.delete(t)
    CardDealer.instance.giveTreasureBack(t)
    
    if @pendingBadConsequence!=nil && !@pendingBadConsequence.isEmpty
      @pendingBadConsequence.substractVisibleTreasures(t)
    end
    
    dieIfNoTreasures
  end
  
  def discardHiddenTreasure(t)
    @hiddenTreasures.delete(t)
    CardDealer.instance.giveTreasureBack(t)
    
    if @pendingBadConsequence!=nil && !@pendingBadConsequence.isEmpty
      @pendingBadConsequence.substractHiddenTreasures(t)
    end
    
    dieIfNoTreasures
  end
  
  def validState
    if @pendingBadConsequence.isEmpty && @hiddenTreasures.length<=4
      return true
    else
      return false
    end
  end
  
  def initTreasures
    dealer=CardDealer.instance
    dice=Dice.instance
    bringToLife
    treasure=dealer.nextTreasure
    @hiddenTreasures<<treasure
    number=dice.nextNumber
        
    if number>1
      treasure=dealer.nextTreasure
      @hiddenTreasures<<treasure
    end
        
    if number==6
      treasure=dealer.nextTreasure
      @hiddenTreasures<<treasure
    end
  end
  
  def discardAllTreasures
    visibleCopy=Array.new(@visibleTreasures)
    hiddenCopy=Array.new(@hiddenTreasures)
        
    visibleCopy.each { |x|
      discardVisibleTreasure(x)
    }
    hiddenCopy.each { |y|
      discardHiddenTreasure(y)
    }
  end
  
  def to_s
    "#{@name}, nivel #{@level}, nivel de combate #{getCombatLevel}\nMal rollo que cumplir: #{@pendingBadConsequence.aCumplir}"
  end
  
  #EXAMEN
  def other_to_s
    "#{@name}, nivel #{@level}, nivel de combate #{getCombatLevel}\nTesoros visibles: #{@visibleTreasures}, tesoros ocultos: #{@hiddenTreasures}\n"  end
  
  #FINEXAMEN
  
end

end