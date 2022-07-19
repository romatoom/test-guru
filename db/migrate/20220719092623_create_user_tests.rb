class CreateUserTests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tests, :id => false do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true

      t.timestamps
    end
  end
end
