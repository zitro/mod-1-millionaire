class AddIncorrectAnswerColumnsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :incorrect_answer1, :string
    add_column :questions, :incorrect_answer2, :string
    add_column :questions, :incorrect_answer3, :string
    remove_column :questions, :incorrect_answers, :string
  end
end
