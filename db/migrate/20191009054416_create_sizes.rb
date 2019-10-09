class CreateSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sizes do |t|
      t.string :name, null: false
      t.string :ancestry
      t.timestamps
    end
    add_index :sizes, :ancestry
  end
end
