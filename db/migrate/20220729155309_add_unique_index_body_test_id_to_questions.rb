class AddUniqueIndexBodyTestIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_index :questions, [:body, :test_id], unique: true
  end
end
