class AddIncorrectAnswerColumnsToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :incorrect_answer1, :string
    add_column :questions, :incorrect_answer2, :string
    add_column :questions, :incorrect_answer3, :string
    remove_column :questions, :incorrect_answers, :string
  end
end
