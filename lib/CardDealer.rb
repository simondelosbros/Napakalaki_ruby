#encoding: utf-8

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'
require_relative 'Treasure.rb'
require_relative 'Monster.rb'
require_relative 'Cultist.rb'
require_relative 'NumericBadConsequence.rb'
require_relative 'SpecificBadConsequence.rb'
require_relative 'DeathBadConsequence.rb'

module NapakalakiGame

class CardDealer
  include Singleton
  
  private
  def initialize
    @unusedMonsters=Array.new
    @usedMonsters=Array.new
    @unusedTreasures=Array.new
    @usedTreasures=Array.new
    @unusedCultists=Array.new
  end
  
  def initTreasureCardDeck
    @unusedTreasures << Treasure.new("¡Sí mi amo!", 4, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("Botas de investigación", 3, NapakalakiGame::TreasureKind::SHOES)
    @unusedTreasures << Treasure.new("Capucha de Cthulhu", 3, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("A prueba de babas", 2, NapakalakiGame::TreasureKind::ARMOR)
    @unusedTreasures << Treasure.new("Botas de lluvia ácida", 1, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Casco minero", 2, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("Ametralladora de Thompson", 4, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Camiseta de la UGR", 1, NapakalakiGame::TreasureKind::ARMOR)
    @unusedTreasures << Treasure.new("Clavo de rail ferroviario", 3, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Cuchillo de sushi arcano", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Fez alópodo", 3, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("Hacha prehistórica", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("El aparato de Pr. Tesla", 4, NapakalakiGame::TreasureKind::ARMOR)
    @unusedTreasures << Treasure.new("Gaita", 4, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Insecticida", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Escopeta de 3 cañones", 4, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Garabato místico", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("La rebeca metálica", 2, NapakalakiGame::TreasureKind::ARMOR)
    @unusedTreasures << Treasure.new("Lanzallamas", 4, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Necro-comicón", 1, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Necronomicón", 5, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Linterna a 2 manos", 3, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Necro-gnomicón", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Necrotelecom", 2, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("Mazo de los antiguos", 3, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Necro-playboycón", 3, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Porra preternatural", 2, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Shogulador", 1, NapakalakiGame::TreasureKind::BOTHHANDS)
    @unusedTreasures << Treasure.new("Varita de atizamiento", 3, NapakalakiGame::TreasureKind::ONEHAND)
    @unusedTreasures << Treasure.new("Tentáculo de pega", 2, NapakalakiGame::TreasureKind::HELMET)
    @unusedTreasures << Treasure.new("Zapato deja-amigos", 1, NapakalakiGame::TreasureKind::SHOES)
  end
  
  def initMonsterCardDeck
    prize = Prize.new(2,1)
    bad_consequence = SpecificBadConsequence.new('Pierdes tu armadura visible y otra oculta.', 0, [NapakalakiGame::TreasureKind::ARMOR], [NapakalakiGame::TreasureKind::ARMOR])
    @unusedMonsters << Monster.new('3 Byakhees de bonanza', 8, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('Embobados con el lindo primigenio te descartas de tu casco visible.', 0, [NapakalakiGame::TreasureKind::HELMET], Array.new)
    @unusedMonsters << Monster.new('Chibithulhu', 2, bad_consequence, prize)

    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('El primordial bostezo contagioso. Pierdes el calzado visible.', 0, [NapakalakiGame::TreasureKind::SHOES], Array.new)
    @unusedMonsters << Monster.new('El sopor de Dunwich', 2, bad_consequence, prize) 

    prize = Prize.new(4,1)
    bad_consequence = SpecificBadConsequence.new('Te atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y 1 mano oculta', 0,[NapakalakiGame::TreasureKind::ONEHAND], [NapakalakiGame::TreasureKind::ONEHAND])
    @unusedMonsters << Monster.new('Ángeles de la noche ibicenca', 14, bad_consequence, prize) 

    prize = Prize.new(3,1)
    bad_consequence = NumericBadConsequence.new('Pierdes todos tus tesoros visibles.', 0, BadConsequence.MAXTREASURES, 0)
    @unusedMonsters << Monster.new('El gorrón en el umbral', 10, bad_consequence, prize) 

    prize = Prize.new(2,1)
    bad_consequence = SpecificBadConsequence.new('Pierdes la armadura visible.', 0, [NapakalakiGame::TreasureKind::ARMOR], Array.new)
    @unusedMonsters << Monster.new('H.P. Munchcraft', 6, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('Sientes bichos bajo la ropa. Descarta la armadura visible.', 0, [NapakalakiGame::TreasureKind::ARMOR], Array.new)
    @unusedMonsters << Monster.new('Bichgooth', 2, bad_consequence, prize) 

    prize = Prize.new(4,2)
    bad_consequence = NumericBadConsequence.new('Pierdes 5 niveles y 3 tesoros visible.', 5, 3, 0)
    @unusedMonsters << Monster.new('El rey de la rosa', 13, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = NumericBadConsequence.new('Toses los pulmones y pierdes dos niveles.', 2, 0, 0)
    @unusedMonsters << Monster.new('La que redacta en las tinieblas', 2, bad_consequence, prize) 

    prize = Prize.new(2,1)
    bad_consequence = DeathBadConsequence.new('Estos monstruos resultan bastante superficiales y te aburren mortalmente. Estás muerto.')
    @unusedMonsters << Monster.new('Los hondos', 8, bad_consequence, prize) 

    prize = Prize.new(2,1)
    bad_consequence = NumericBadConsequence.new('Pierdes 2 niveles y 2 tesoros ocultos.', 2, 0, 2)
    @unusedMonsters << Monster.new('Semillas Cthulhu', 4, bad_consequence, prize) 

    prize = Prize.new(2,1)
    bad_consequence = SpecificBadConsequence.new('Te intentas escaquear. Pierdes una mano visible.', 0, [NapakalakiGame::TreasureKind::ONEHAND], Array.new)
    @unusedMonsters << Monster.new('Dameargo', 1, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = NumericBadConsequence.new('Da mucho asquito. Pierdes 3 niveles.', 3, 0, 0)
    @unusedMonsters << Monster.new('Pollipólipo volante', 3, bad_consequence, prize) 

    prize = Prize.new(3,1)
    bad_consequence = DeathBadConsequence.new('No le hace gracia que pronuncien mal su nombre. Estás muerto.')
    @unusedMonsters << Monster.new('Yskhtihyssg-Goth', 12, bad_consequence, prize) 

    prize = Prize.new(4,1)
    bad_consequence = DeathBadConsequence.new('La familia te atrapa. Estás muerto')
    @unusedMonsters << Monster.new('Familia feliz', 1, bad_consequence, prize) 

    prize = Prize.new(2,1)
    bad_consequence = SpecificBadConsequence.new('La quinta directiva de primaria te obliga a perder 2 niveles y un tesoro 2 manos visible.', 2, [NapakalakiGame::TreasureKind::BOTHHANDS], Array.new)
    @unusedMonsters << Monster.new('Roboggoth', 8, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('Te asusta en la noche. pierdes un casco visible.', 0, [NapakalakiGame::TreasureKind::HELMET], Array.new)
    @unusedMonsters << Monster.new('El espia', 5, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = NumericBadConsequence.new('Menudo susto te llevas. Pierdes 2 niveles y 5 tesoros visibles.', 2, 5, 0)
    @unusedMonsters << Monster.new('El Lenguas', 20, bad_consequence, prize) 

    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('Te faltan manos para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos.', 3, [NapakalakiGame::TreasureKind::ONEHAND, NapakalakiGame::TreasureKind::BOTHHANDS], Array.new)
    @unusedMonsters << Monster.new('Bicéfalo', 20, bad_consequence, prize)

    #MONSTRUOS QUE AFECTAN A SECTARIOS
    prize = Prize.new(3,1)
    bad_consequence = SpecificBadConsequence.new('Pierdes una mano visible.', 0, [NapakalakiGame::TreasureKind::ONEHAND], Array.new)
    @unusedMonsters << Monster.new('El mal indecible impronunciable', 10, bad_consequence, prize, -2)
    
    prize = Prize.new(2,1)
    bad_consequence = NumericBadConsequence.new('Pierdes todos tus tesoros visible. Jajaja.', 0, BadConsequence.MAXTREASURES, 0)
    @unusedMonsters << Monster.new('Testigos Oculares', 6, bad_consequence, prize, +2)
    
    prize = Prize.new(2,5)
    bad_consequence = DeathBadConsequence.new('Hoy no es tu día de suerte. Mueres.')
    @unusedMonsters << Monster.new('El gran Cthulhu', 20, bad_consequence, prize, +4)
    
    prize = Prize.new(2,1)
    bad_consequence = NumericBadConsequence.new('Tu gobierno te recorta dos niveles.', 2, 0, 0)
    @unusedMonsters << Monster.new('Serpiente Político', 8, bad_consequence, prize, -2)
    
    prize = Prize.new(1,1)
    bad_consequence = SpecificBadConsequence.new('Pierdes tu casco y tu armadura visible. Pierdes tus manos ocultas.', 0, [NapakalakiGame::TreasureKind::HELMET, NapakalakiGame::TreasureKind::ARMOR], [NapakalakiGame::TreasureKind::BOTHHANDS, NapakalakiGame::TreasureKind::ONEHAND])
    @unusedMonsters << Monster.new('Felpuggoth', 2, bad_consequence, prize, +5)
    
    prize = Prize.new(4,2)
    bad_consequence = NumericBadConsequence.new('Pierdes dos niveles.', 2, 0, 0)
    @unusedMonsters << Monster.new('Shoggoth', 16, bad_consequence, prize, -4)
  
    prize = Prize.new(1,1)
    bad_consequence = NumericBadConsequence.new('Pintalabios negro. Pierdes dos niveles.', 2, 0, 0)
    @unusedMonsters << Monster.new('Lolitagooth', 2, bad_consequence, prize, +3)
  end
  
  def initCultistCardDeck
    @unusedCultists << Cultist.new('Agaricus', 1)
    @unusedCultists << Cultist.new('Boletus', 2)
    @unusedCultists << Cultist.new('Daldinia', 1)
    @unusedCultists << Cultist.new('Bolbitius', 2)
    @unusedCultists << Cultist.new('Calvatia', 1)
    @unusedCultists << Cultist.new('Dermoloma', 1)
  end
  
  def shuffleTreasures
    @unusedTreasures.shuffle!
  end
  
  def shuffleMonsters
    @unusedMonsters.shuffle!
  end
  
  def shuffleCultists
    @unusedCultists.shuffle!
  end
  
  public
=begin
  def self.getInstance
    return self.instance
  end
=end
  def nextTreasure
    if @unusedTreasures.empty?
      @unusedTreasures=Array.new(@usedTreasures)
      @usedTreasures.clear
      shuffleTreasures
    end
    
    a_devolver=@unusedTreasures.at(0)
    @unusedTreasures.delete_at(0)
    return a_devolver
  end
  
  def nextMonster
    if @unusedMonsters.empty?
      @unusedMonsters=Array.new(@usedMonsters)
      @usedMonsters.clear
      shuffleMonsters
    end
    
    a_devolver=@unusedMonsters.at(0)
    @unusedMonsters.delete_at(0)
    return a_devolver
  end
  
  def nextCultist
    a_devolver=@unusedCultists.at(0)
    @unusedCultists.delete_at(0)
    return a_devolver
  end
  
  def giveTreasureBack(t)
    @usedTreasures << t
  end
  
  def giveMonsterBack(m)
    @usedMonsters << m
  end
  
  def initCards
    initTreasureCardDeck
    initMonsterCardDeck
    initCultistCardDeck
    shuffleMonsters
    shuffleTreasures
    shuffleCultists
  end
  
end

end