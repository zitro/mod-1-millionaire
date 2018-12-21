class CreateGameCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :game_categories do |t|
      t.integer :game_id
      t.integer :category_id
    end
  end
end
