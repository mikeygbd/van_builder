class AddUserIdToVans < ActiveRecord::Migration
  def change
    add_column :vans, :user_id, :integer 
  end
end
