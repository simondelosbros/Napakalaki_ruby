#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'
require_relative 'Monster.rb'
require_relative 'Player.rb'
require_relative 'CombatResult.rb'
require_relative 'CardDealer.rb'
require_relative 'CultistPlayer.rb'

module NapakalakiGame

class Napakalaki
  include Singleton
  @currentPlayerIndex
  @currentMonster
  @dealer
  @currentPlayer
  @players
  
  private
  def initialize
    @currentPlayer=nil
    @currentMonster=nil
    @dealer=CardDealer.instance
  end
  
  def initPlayers(names)
    @players=Array.new
    names.each { |x|
      @players<<Player.new(x)
    }
  end
  
  def nextPlayer
    if @currentPlayer==nil
      numeroAleatorio=rand(@players.length)
      @currentPlayerIndex=numeroAleatorio
    else
      if @currentPlayerIndex==@players.length-1
        @currentPlayerIndex=0
      else
        @currentPlayerIndex+=1
      end
    end
    
    @currentPlayer=@players.at(@currentPlayerIndex)
  
    return @currentPlayer
  end
  
  def nextTurnAllowed
    if @currentPlayer==nil
      return true
    else
      return @currentPlayer.validState
    end
  end
  
  public
=begin
  def self.getInstance
    return self.instace
  end
=end
  def developCombat
    some_combat=@currentPlayer.combat(@currentMonster)
    if some_combat==NapakalakiGame::CombatResult::LOSEANDCONVERT
      cultistcard=@dealer.nextCultist
      newcultistplayer=CultistPlayer.new(@currentPlayer, cultistcard)
      @currentPlayer=newcultistplayer
      @players.insert(@currentPlayerIndex, @currentPlayer)
      @players.delete_at(@currentPlayerIndex+1)
    end
    @dealer.giveMonsterBack(@currentMonster)
    return some_combat
  end
  
  def discardVisibleTreasures(treasures)
    treasures.each { |x|
      @currentPlayer.discardVisibleTreasure(x)
    }
  end
  
  def discardHiddenTreasures(treasures)
    treasures.each { |x|
      @currentPlayer.discardHiddenTreasure(x)
    }
  end
  
  def makeTreasuresVisible(treasures)
    treasures.each { |x|
      @currentPlayer.makeTreasureVisible(x)
    }
  end
  
  def initGame(players)
    initPlayers(players)
    @dealer.initCards
    nextTurn
  end

  def getCurrentPlayer
    @currentPlayer
  end
  
  def getCurrentMonster
    @currentMonster
  end

  def nextTurn
    stateOK=nextTurnAllowed
    
    if(stateOK)
      @currentMonster=@dealer.nextMonster
      @currentPlayer=nextPlayer
      dead=@currentPlayer.isDead
      if dead
        @currentPlayer.initTreasures
      end
    end
    
    return stateOK
  end
  
  def endOfGame(result)
    return result==CombatResult::WINGAME
  end
  
end

end