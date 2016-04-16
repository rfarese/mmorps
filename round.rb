require_relative 'round'
require_relative 'player'

class Round
  WIN_CONDITIONS = {
    "Rock" => "Scissors",
    "Scissors" => "Paper",
    "Paper" => "Rock"
  }

  attr_reader :player, :computer, :winner

  def initialize(player, computer)
    @computer = computer
    @player = player
  end

  def get_winner
    if player.choice == computer.choice
       @winner = "Tie"
     elsif WIN_CONDITIONS[player.choice] == computer.choice
       @winner = player.name
       player.wins += 1
     elsif WIN_CONDITIONS[computer.choice] == player.choice
       @winner = computer.name
       computer.wins += 1
     end
     @winner
  end
end
