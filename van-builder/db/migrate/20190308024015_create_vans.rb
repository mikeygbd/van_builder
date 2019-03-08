class CreateVans < ActiveRecord::Migration
  def change
    create_table :vans do |t|
      t.string :name
      t.string :make
      t.string :model
      t.integer :year
    end
  end
end
