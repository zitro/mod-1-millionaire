class AddBetToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :bet, :integer, default: 0
  end
end
