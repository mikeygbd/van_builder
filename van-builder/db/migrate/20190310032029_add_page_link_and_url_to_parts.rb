class AddPageLinkAndUrlToParts < ActiveRecord::Migration
  def change
    add_column :parts, :url, :string
    add_column :parts, :page_link, :string
  end
end
