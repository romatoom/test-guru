
class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :body, null: false
      t.integer :test_id, null: false
      t.index ["test_id"], name: "index_questions_on_test_id"

      t.timestamps
    end
  end
end
