class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title, null: false, unique: true
      t.string :url, null: false, unique: true
      t.string :description, null: false, unique: true
      t.string :rule, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
