class ChangePublishedAtColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests, :published_at
    add_column :tests, :published, :boolean, null: false, default: false
  end
end
