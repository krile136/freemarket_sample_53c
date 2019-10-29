class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :good, :integer
    add_column :users, :fair, :integer
    add_column :users, :bad, :integer
  end
end
