class AddCorrectAnswersCurrentQuestionToUsersTests < ActiveRecord::Migration[6.1]
  def change
    add_column :users_tests, :correct_answers, :integer, default: 0
    add_reference :users_tests, :current_question, foreign_key: { to_table: :questions }
  end
end
