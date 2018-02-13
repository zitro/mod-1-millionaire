require_relative '../config/environment'
require "pry"
require 'rest-client'
require 'json'

system "clear"
game = Game.new
game.start_game

binding.pry
