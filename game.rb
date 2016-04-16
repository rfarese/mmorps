class Game
  attr_reader :player, :computer, :winner

  def set_players(player, computer)
    @player = player
    @computer = computer
  end

  def winner
    if player.wins > 1
      @winner = player.name
    end

    if computer.wins > 1
      @winner = computer.name
    end
    @winner
  end
end
