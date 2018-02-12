class Game < ActiveRecord::Base
  #controller
  #join table
  #initiate the game
  #call on api
  #pass on user input
  #scores are kept for user
  belongs_to :user
  belongs_to :api

end
