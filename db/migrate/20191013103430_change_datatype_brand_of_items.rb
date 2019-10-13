class ChangeDatatypeBrandOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :brand, :string
  end
end
