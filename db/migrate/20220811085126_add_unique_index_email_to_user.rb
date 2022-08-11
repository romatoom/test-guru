class AddUniqueIndexEmailToUser < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
    change_column_null :users, :email, false
  end
end
