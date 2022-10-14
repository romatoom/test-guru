class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title, null: false, index: { unique: true }
      t.string :url, null: false
      t.string :description, null: false
      t.string :rule_name, null: false
      t.string :rule_param, null: false
      t.string :rule_condition, null: false

      t.timestamps
    end
  end
end
