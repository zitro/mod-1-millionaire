class CreateGames < ActiveRecord::Migration[4.2]
  def change
    create_table :games do |t|
      t.integer :user_id
    end
  end
end
