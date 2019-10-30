class AddColumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :good, :integer
  end
end
