class RemoveVanIdFromParts < ActiveRecord::Migration
  def change
    remove_column :parts, :van_id
  end
end
