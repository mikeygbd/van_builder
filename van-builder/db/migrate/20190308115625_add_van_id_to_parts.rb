class AddVanIdToParts < ActiveRecord::Migration
  def change
    add_column :parts, :van_id, :integer 
  end
end
