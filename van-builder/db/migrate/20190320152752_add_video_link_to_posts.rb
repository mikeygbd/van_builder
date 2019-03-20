class AddVideoLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :video_link, :string
    add_column :posts, :url, :string
  end
end
