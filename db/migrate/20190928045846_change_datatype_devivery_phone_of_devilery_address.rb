class ChangeDatatypeDeviveryPhoneOfDevileryAddress < ActiveRecord::Migration[5.2]
  def change
    change_column :delivery_addresses, :delivery_phone, :string
  end
end
