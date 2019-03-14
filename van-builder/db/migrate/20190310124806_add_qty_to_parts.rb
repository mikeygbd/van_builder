class AddQtyToParts < ActiveRecord::Migration
  def change
    add_column :parts, :qty, :integer

  end
end
