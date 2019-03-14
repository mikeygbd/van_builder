class AddManufactureToParts < ActiveRecord::Migration
  def change
    add_column :parts, :manufacturer, :string 
  end
end
