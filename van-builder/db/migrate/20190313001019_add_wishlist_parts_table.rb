class AddWishlistPartsTable < ActiveRecord::Migration
  def change
    create_table :wishlist_parts do |t|
      t.string  :name
      t.float :price
      t.string  :description
      t.string  :manufacturer
      t.integer :user_id
      t.string  :url
      t.string  :page_link
      t.integer :qty
    end
  end
end
