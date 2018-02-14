require_relative '../config/environment'
require "pry"
require 'rest-client'
require 'json'

# system `say -v Fred hello`

Question.delete_all
Category.save_questions

system "clear"

game = Game.new
game.start_game

binding.pry
