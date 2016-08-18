#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame

class CultistPlayer < Player
  @@totalCultistPlayers=0
  
  def initialize(player, card)
    super(player.name)
    copy_constructor(player)
    @myCultistCard=card
    @@totalCultistPlayers+=1
  end
  
  protected
  
  def getCombatLevel
    level=super
    level*=1.5
    level+=@myCultistCard.getGainedLevels*@@totalCultistPlayers
    a_devolver=level.to_int
    return a_devolver;
  end
  
  def getOponentLevel(m)
    return m.getCombatLevelAgainstCultistPlayer
  end
  
  def shouldConvert
    return false
  end
  
  public
  
  def self.getTotalCultistPlayers
    @@totalCultistPlayers
  end
end

end
