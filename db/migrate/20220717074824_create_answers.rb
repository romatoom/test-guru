class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :correct, default: false, null: false
      t.integer :question_id, null: false
      t.index ["question_id"], name: "index_answers_on_question_id"

      t.timestamps
    end
  end
end
