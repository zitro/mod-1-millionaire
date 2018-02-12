class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.string :category
      t.string :question
      t.string :difficulty
      t.string :correct_answer
      t.string :incorrect_answers
    end
  end
end
