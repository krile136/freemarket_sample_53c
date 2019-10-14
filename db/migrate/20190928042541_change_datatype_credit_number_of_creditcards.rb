class ChangeDatatypeCreditNumberOfCreditcards < ActiveRecord::Migration[5.2]
  def change
    change_column :creditcards, :credit_number, :string
  end
end
