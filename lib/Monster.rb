#encoding: utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'Prize.rb'
require_relative 'BadConsequence.rb'

module NapakalakiGame

class Monster
  attr_reader :name, :combatLevel, :badConsequence, :prize
  @levelChangeAgainstCultistPlayer=0
=begin
  #EXAMEN
  @@TOTAL_MONSTERS=0
  #FIN EXAMEN
=end  
  public
  def initialize(aName, someCombatLevel, someBc, somePrize, lC=0)
    @name=aName
    @combatLevel=someCombatLevel
    @badConsequence=someBc
    @prize=somePrize
    @levelChangeAgainstCultistPlayer=lC
=begin
    #EXAMEN
    @@TOTAL_MONSTERS+=1
    #FIN EXAMEN
=end
  end
  
  def getCombatLevel
    @combatLevel
  end
  
  def getCombatLevelAgainstCultistPlayer
    @levelChangeAgainstCultistPlayer+getCombatLevel
  end
  
  def getBadConsequence
    @badConsequence
  end
  
  def getLevelsGained
    @prize.levels
  end
  
  def getTreasuresGained
    @prize.treasures
  end
=begin  
  #EXAMEN
  def self.getNumberOfMonsters
    @@TOTAL_MONSTERS
  end
  #FIN EXAMEN
=end  
  
  def to_s
    "Name = #{@name}, Combat Level = #{@combatLevel}.\n#{@badConsequence.to_s}Bonus: #{getTreasuresGained} tesoros y #{getLevelsGained} nivel.\nContra sectarios: #{@levelChangeAgainstCultistPlayer}."
  end  
  
end

end