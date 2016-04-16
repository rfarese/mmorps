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
  session[:choose] = ""

  if session[:visit_count].nil?
    session[:visit_count] = 1
    session[:player] = Player.new
    session[:computer] = Computer.new
    session[:game] = Game.new
  else
    session[:visit_count] += 1
  end

  erb :index
end

post '/' do
  session[:choice] = params[:choice]
  player = session[:player]
  computer = session[:computer]
  game = session[:game]

  # get choices
  @player_choice = player.chooses(session[:choice])
  @computer_choice = computer.chooses

  # create new round with choices
  session[:round] = Round.new(player, computer)
  round = session[:round]

  @round_winner = round.get_winner
  @player_wins = player.wins
  @computer_wins = computer.wins

  # add player objects to game object
  game.set_players(player, computer)
  @game_winner = game.winner
  binding.pry

  erb :index
end

post '/reset' do
  session[:visit_count] = nil

  redirect '/'
end
