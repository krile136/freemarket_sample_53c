class AddBrandToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :brand, :integer
  end
end