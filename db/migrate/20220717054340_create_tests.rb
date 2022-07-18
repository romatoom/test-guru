class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.integer :level, default: 0, null: false
      t.integer :category_id, null: false
      t.index ["category_id"], name: "index_tests_on_category_id"

      t.timestamps
    end
  end
end
