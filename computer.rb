require_relative 'round'
require_relative 'player'

class Computer
  attr_reader :name
  attr_accessor :choice, :wins

  def initialize
    @wins = 0
    @name = "Computer"
  end

  def chooses
    @choice = ['Rock', 'Paper', 'Scissors'].sample
  end
end
