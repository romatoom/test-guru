class AddTimeToPassToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :time_to_pass, :string, default: "00:00:00"
  end
end
