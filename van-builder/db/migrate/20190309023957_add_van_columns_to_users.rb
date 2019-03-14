class AddVanColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :van_make, :string
    add_column :users, :van_model, :string
    add_column :users, :van_year, :integer
    add_column :users, :van_wheelbase, :integer  
  end
end
