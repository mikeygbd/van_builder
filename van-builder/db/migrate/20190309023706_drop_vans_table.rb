class DropVansTable < ActiveRecord::Migration
  def change
    drop_table :vans
  end
end
