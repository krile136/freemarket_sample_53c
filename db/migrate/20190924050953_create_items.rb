class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string    :name, null: false
      t.integer   :price, null: false
      t.text      :description, null: false
      t.integer   :size_id, foreign_key: true
      t.integer   :condition_id, null: false, foreign_key: true
      t.integer   :category_id, null: false, foreign_key: true
      t.integer   :brand_id, foreign_key: true
      t.integer   :delivery_day_id, null: false, foreign_key: true
      t.integer   :delivery_method_id, null: false, foreign_key: true
      t.integer   :prefecture_id, null: false, foreign_key: true
      t.integer   :seller_id, null: false, index: true, foreign_key: true
      t.integer   :buyer_id, index: true, foreign_key: true
      t.integer   :postage_burden_id, null: false, foreign_key: true
      t.integer   :parent_id, null: false, index: true
      t.integer   :child_id, null: false, index: true
      t.string    :brand
      t.timestamps
    end
  end
end
