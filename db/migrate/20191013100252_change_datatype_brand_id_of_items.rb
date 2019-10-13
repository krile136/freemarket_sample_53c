class ChangeDatatypeBrandIdOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :brand_id, :integer
  end
end
