class User < ActiveRecord::Base
  #creates user
  #has a name and a score
  #has many games
  #create the game
  :has_many :games
  

end
