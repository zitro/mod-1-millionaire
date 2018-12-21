class AddQuestionToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :question, :string
  end
end
