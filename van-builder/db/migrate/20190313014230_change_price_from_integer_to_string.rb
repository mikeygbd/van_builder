class ChangePriceFromIntegerToString < ActiveRecord::Migration
  def change
    change_column :parts, :price, :string
  end
end
