require_relative '../config/environment'
require "pry"
require 'rest-client'
require 'json'

Question.delete_all
Category.save_questions

system "clear"

game = Game.new
game.start_game

binding.pry
