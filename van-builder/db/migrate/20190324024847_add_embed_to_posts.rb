class AddEmbedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embed, :string
  end
end
