class User < ActiveRecord::Base
has_many :parts
has_many :wishlist_parts
has_secure_password

  def slug
  end

  def self.find_by_slug(slug)
  end

end
