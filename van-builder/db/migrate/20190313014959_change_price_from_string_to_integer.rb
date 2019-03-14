class ChangePriceFromStringToInteger < ActiveRecord::Migration
  def change
    change_column :parts, :price, :integer
  end
end
