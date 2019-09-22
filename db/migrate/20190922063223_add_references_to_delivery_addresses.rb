class AddReferencesToDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_addresses, :prefecture_id, :string, null: false
    add_reference :delivery_addresses, :user, null: false, foreign_key: true
  end
end
