class ChangeImageToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :images, :image_url, :string, null: true 
  end
  def down
    change_column :images, :image_url, :string, null: false
  end
end

