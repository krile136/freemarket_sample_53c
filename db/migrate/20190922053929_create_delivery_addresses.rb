class CreateDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_addresses do |t|
      t.string :delivery_last_name, null: false
      t.string :delivery_first_name, null: false
      t.string :delivery_last_name_kana, null: false
      t.string :delivery_first_name_kana, null: false
      t.string :delivery_postal_code, null: false
      # t.references :delivery_prefecture_id, null: false, foreign_key: true, type: :integer
      t.string :delivery_city, null: false
      t.string :delivery_address, null: false
      t.string :delivery_building
      t.integer :delivery_phone
      # t.references :user_id, null: false, foreign_key: true, type: :integer
      t.timestamps
    end
  end
end
