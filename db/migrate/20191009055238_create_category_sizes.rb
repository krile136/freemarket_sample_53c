class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.integer :category_id, null: false, index: true, foreign_key: true
      t.integer :size_id, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
