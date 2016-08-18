# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'

module NapakalakiGame

class Dice
  include Singleton
  
  private
  def initialize
    
  end
  
  public
=begin
  def self.getInstance
    return self.instance
  end
=end
  def nextNumber
    return rand(6)+1
  end
  
end

end