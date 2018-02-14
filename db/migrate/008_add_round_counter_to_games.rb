class AddRoundCounterToGames < ActiveRecord::Migration[4.2]
  def change
    add_column :games, :round_counter, :integer, default: 0
  end
end
