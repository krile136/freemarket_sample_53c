class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string, null: false
    add_column :users, :phone, :integer, null: false
    add_column :users, :profile, :string
    add_column :users, :last_name, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name_kana, :string, null: false
    add_column :users, :first_name_kana, :string, null: false
    add_column :users, :birth_year, :integer, null: false;
    add_column :users, :birth_month, :integer, null: false;
    add_column :users, :birth_day, :integer, null: false;
    add_column :users, :icon, :string
    add_column :users, :active, :boolean
    add_column :users, :receivable, :integer
  end
end
