class AddPostageBurdenToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :postage_burden_id, :integer, null: false, foreign_key: true
    add_column :items, :parent_id, :integer, null: false, index: true
    add_column :items, :child_id, :integer, null: false, index: true
  end
end
