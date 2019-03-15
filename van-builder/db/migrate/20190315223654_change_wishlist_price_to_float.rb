class ChangeWishlistPriceToFloat < ActiveRecord::Migration
  def change
    change_column :wishlist_parts, :price, :float
  end
end
