require 'pry'
require "sinatra"
require_relative 'player'
require_relative 'computer'
require_relative 'round'
require_relative 'game'

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

get '/' do
  if session[:visit_count].nil?
    session[:visit_count] = 1
    session[:player] = Player.new
    session[:computer] = Computer.new
    session[:game] = Game.new
  else
    @player_choice = session[:player].choice
    @computer_choice = session[:computer].choice
    @round_winner = session[:round].winner
    @player_wins = session[:player].wins
    @computer_wins = session[:computer].wins
    @game_winner = session[:game].winner
  end

  erb :index
end

post '/choose' do
  session[:choice] = params[:choice]
  player = session[:player]
  computer = session[:computer]
  game = session[:game]

  # get choices
  player.chooses(session[:choice])
  computer.chooses

  # create new round with choices
  session[:round] = Round.new(player, computer)
  round = session[:round]

  round.get_winner
  player.wins
  computer.wins

  # add player objects to game object
  game.set_players(player, computer)
  game.get_winner

  redirect '/'
end

post '/reset' do
  session[:visit_count] = nil

  redirect '/'
end
