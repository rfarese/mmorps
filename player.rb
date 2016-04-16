require_relative 'round'
require_relative 'player'

class Player
  attr_reader :name
  attr_accessor :choice, :wins

  def initialize
    @wins = 0
    @name = "Player"
  end

  def chooses(choice)
    @choice = choice
  end
end
