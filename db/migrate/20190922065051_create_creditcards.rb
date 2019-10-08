class CreateCreditcards < ActiveRecord::Migration[5.2]
  def change
    create_table :creditcards do |t|
      t.integer :credit_number, null: false
      t.integer :limit_month, null: false
      t.integer :limit_year, null: false
      t.integer :security_number, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
