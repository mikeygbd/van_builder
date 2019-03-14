class AddVanColorAndVanWheelbaseToUser < ActiveRecord::Migration
  def change
    add_column :users, :van_color, :string
  end
end
