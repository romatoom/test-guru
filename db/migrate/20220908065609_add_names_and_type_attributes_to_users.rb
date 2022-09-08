class AddNamesAndTypeAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type, :string, null: false, default: "User"
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    rename_column :users, :name, :nickname
  end
end
